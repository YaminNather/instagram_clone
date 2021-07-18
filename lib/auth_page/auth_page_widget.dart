import "package:flutter/material.dart";
import 'package:instagram_ui_clone/auth_widgets/auth_styles.dart' as styles;
import 'package:instagram_ui_clone/global_provider.dart';

class WAuthPage extends StatelessWidget {
  const WAuthPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(body: _buildBody(context));

  Widget _buildBody(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      alignment: Alignment.center,
      child: Column(        
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildLogo(context),          

          const SizedBox(height: 70.0),

          _buildSignInButton(context),

          const SizedBox(height: 50.0),

          _buildSignUpButton(context)          
        ]
      )
    );   
  }

  Widget _buildLogo(final BuildContext context) {
    final String url = GlobalProvider.of(context).logoURLBig;

    return Padding( padding: const EdgeInsets.all(64.0), child: Image.network(url, fit: BoxFit.contain) );
  }

  Widget _buildSignInButton(final BuildContext context) {
    void onPressedCallback() => Navigator.pushNamed( context, "Sign In Page");

    return SizedBox(
      height: _buttonHeight, 
      child: ElevatedButton(
        child: const Text("Log in"), style: styles.getElevatedButtonStyle(), onPressed: onPressedCallback
      )
    );
  }

  Widget _buildSignUpButton(final BuildContext context) {
    void onPressedCallback() => Navigator.pushNamed(context, "Sign Up Page");
    
    return SizedBox(
      height: _buttonHeight, 
      child: OutlinedButton(
        child: const Text("Sign up"), style: styles.getOutlinedButtonStyle(), onPressed: onPressedCallback
      )
    );
  }  



  static const double _buttonHeight = 50.0;
}