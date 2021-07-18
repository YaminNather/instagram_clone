import "package:flutter/material.dart";
import 'package:instagram_ui_clone/global_provider.dart';
import 'package:instagram_ui_clone/utils/widget_utils.dart';
import 'package:instagram_ui_clone/widgets/url_widget.dart';

import "package:instagram_ui_clone/auth_widgets/auth_styles.dart" as styles;

class WSignInPage extends StatefulWidget {
  const WSignInPage({ Key? key }) : super(key: key);

  @override
  _WSignInPageState createState() => _WSignInPageState();
}

class _WSignInPageState extends State<WSignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(context));
  }

  AppBar _buildAppBar() => AppBar();

  Widget _buildBody(final BuildContext context) {
    final ThemeData theme = Theme.of(context);    

    return LayoutBuilder(
      builder: (context, constraints) {
        print("CustomLog: Constraints = $constraints");        
        final double bodyHeight = getScaffoldBodyHeight(context);

        return SingleChildScrollView(
          child: Container(
            height: bodyHeight, padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLogo(context),

                const SizedBox(height: 64.0),
                
                const _WForm(),

                const SizedBox(height: 64.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    const Expanded(child: const Divider()),
                    
                    const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0), child: const Text("OR")
                    ),

                    const Expanded(child: const Divider())
                  ]
                ),

                const SizedBox(height: 16.0),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Have an account?"),

                    TextButton(
                      child: const Text(" Log in."), 
                      onPressed: () => Navigator.popAndPushNamed(context, "Sign Up Page")
                    )
                  ]
                ),

                const SizedBox(height: 20.0),

                const Spacer(),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    const Divider(),              

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: const Text("Instagram OT Facebook"),
                    )
                  ]
                )
              ]
            )
          ),
        );
      }
    );
  }

  Widget _buildLogo(final BuildContext context) {
    final String url = GlobalProvider.of(context).logoURLBig;
    
    return Padding( 
      padding: const EdgeInsets.symmetric(horizontal: 64.0), child: Image.network(url, fit: BoxFit.contain) 
    );
  }
}




class _WForm extends StatefulWidget {
  const _WForm({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WFormState();
}

class _WFormState extends State<_WForm> {  
  @override
  Widget build(BuildContext context) {
    void onFormChangedCallback() {
      final bool valid = _formKey.currentState!.validate();

      setState(() => formValid = valid);
    }

    return Form(
      key: _formKey,
      onChanged: onFormChangedCallback,      
      child: Wrap(
        runSpacing: 16.0,
        children: <Widget>[        
          _buildUsernameField(),          

          Column(            
            children: <Widget>[
              _buildPasswordField(),

              new Container(
                width: double.infinity, alignment: Alignment.centerRight, child: _buildForgotPasswordButton()
              )
            ]
          ),

          _buildSignInButton()          
        ]
      ),
    );
  }

  Widget _buildUsernameField() {
    String? validatorCallback(String? text) {
      if(text == null)
        return "Enter username";
        
      if(text == "")
        return "Enter username";
        
      if(text.length < 6)
        return "Username must have a minimum of 6 characters";

      return null;
    }    

    return _buildTextFormField(label: "Username", validator: validatorCallback);
  }

  Widget _buildPasswordField() {
    String? validatorCallback(String? text) {
      if(text == null)
        return "Enter password";
        
      if(text == "")
        return "Enter password";
        
      if(text.length < 6)
        return "Password must have a minimum of 6 characters";

      return null;
    }    

    return _buildTextFormField(label: "Password", validator: validatorCallback);
  }

  Widget _buildSignInButton() {
    void onPressedCallback() {
      Navigator.popAndPushNamed(context, "Signed In Page");
    }

    return SizedBox(      
      width: double.infinity, height: 50.0,
      child: ElevatedButton(
        child: const Text("Sign in"),
        style: styles.getElevatedButtonStyle(), 
        onPressed: (formValid) ? onPressedCallback : null
      )
    );
  }

  Widget _buildTextFormField({required final String label, final String? Function(String?)? validator}) {
    final InputDecoration inputDecoration = new InputDecoration(labelText: label);
    
    return new TextFormField(
      decoration: inputDecoration, validator: validator, autovalidateMode: AutovalidateMode.onUserInteraction
    );
  }
  
  Widget _buildForgotPasswordButton() => WURL(text: "Forgot Password?", onPressed: () {});



  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();    
  bool formValid = false;
}