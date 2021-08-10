import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ui_clone/injector.dart';
import 'package:instagram_ui_clone/presentation/sign_in_page/bloc/sign_in_page_bloc.dart';
import 'package:provider/provider.dart';
import '../widgets/instagram_logo_widget.dart';
import '../utils/widget_utils.dart';
import '../widgets/url_widget.dart';

class WSignInPage extends StatefulWidget {
  const WSignInPage({ Key? key }) : super(key: key);

  @override
  _WSignInPageState createState() => _WSignInPageState();
}

class _WSignInPageState extends State<WSignInPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInPageBloc>(
      create: (context) => getIt<SignInPageBloc>(),
      child: Provider<BuildContext>.value(
        value: context,
        child: Scaffold(appBar: _buildAppBar(), body: _buildBody(context))
      )
    );
  }

  AppBar _buildAppBar() => AppBar();

  Widget _buildBody(final BuildContext context) {
    return BlocBuilder<SignInPageBloc, SignInPageState>(
      builder: (context, state) {
        if(state is LoadingState)
          return const Center(child: const CircularProgressIndicator.adaptive());

        return LayoutBuilder(
          builder: (context, constraints) {
            final double bodyHeight = getScaffoldBodyHeight(context);
    
            return SingleChildScrollView(
              child: Container(
                height: bodyHeight, padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildLogo(context),
    
                    const SizedBox(height: 64.0),
                    
                    new _WForm(),
    
                    const SizedBox(height: 32.0),
    
                    _buildOrDivider(),
    
                    const SizedBox(height: 16.0),
                    
                    _buildToSignUpPageSection(),
    
                    const Spacer(),
    
                    _buildFooterSection()
                  ]
                )
              ),
            );
          }
        );
      },
    );
  }

  Widget _buildLogo(final BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0), 
      child: WInstagramLogo()
    );
  }

  Widget _buildOrDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        const Expanded(child: const Divider()),
        
        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), child: const Text("OR")
        ),

        const Expanded(child: const Divider())
      ]
    );
  }

  Widget _buildToSignUpPageSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Don't have an account?"),

        TextButton(
          child: const Text(" Sign up."), 
          onPressed: () => Navigator.popAndPushNamed(context, "Sign Up Page")
        )
      ]
    );
  }

  Widget _buildFooterSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        const Divider(),              

        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: const Text("Instagram OT Facebook"),
        )
      ]
    );
  }
}




class _WForm extends StatelessWidget {
  _WForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInPageBloc bloc = BlocProvider.of(context);

    return Form(
      // key: _formKey,
      child: Wrap(
        runSpacing: 16.0,
        children: <Widget>[        
          _buildUsernameField(bloc),          

          Column(            
            children: <Widget>[
              _buildPasswordField(bloc),

              new Container(
                width: double.infinity, alignment: Alignment.centerRight, 
                child: _buildForgotPasswordButton()
              )
            ]
          ),

          _buildSignInButton(context, bloc)          
        ]
      ),
    );
  }

  Widget _buildUsernameField(final SignInPageBloc bloc) {
    final InputState state = bloc.state as InputState;
    
    String? validatorCallback(String? text) {
      return (state.emailAddressError == "") ? null : state.emailAddressError;
    }    

    void onChangedCallback(String text) => bloc.add(ChangedEmailUsernameEvent(text));    

    return _buildTextFormField(
      label: "Username", validator: validatorCallback, onChanged: onChangedCallback, 
      initialValue: state.emailAddress
    );
  }

  Widget _buildPasswordField(final SignInPageBloc bloc) {
    final InputState state = bloc.state as InputState;
    String? validatorCallback(_) {
      return (state.passwordError.isEmpty) ? null : state.passwordError;
    }    

    void onChangedCallback(String value) {
      bloc.add(ChangedPasswordEvent(value));
    }

    return _buildTextFormField(
      label: "Password", validator: validatorCallback, onChanged: onChangedCallback,
      initialValue: state.password, obscureText: true
    );
  }

  Widget _buildSignInButton(final BuildContext context, final SignInPageBloc bloc) {
    void onPressedCallback() {
      final BuildContext pageContext = Provider.of(context, listen: false);
      bloc.add(new ClickedSignInButtonEvent(pageContext));
    }
    
    final InputState state = bloc.state as InputState;

    final bool isButtonEnabled = state.emailAddress.isNotEmpty && state.emailAddressError.isEmpty 
    && state.password.isNotEmpty && state.passwordError.isEmpty;

    return SizedBox(      
      width: double.infinity, height: 50.0,
      child: ElevatedButton(
        child: const Text("Sign in"), onPressed: (isButtonEnabled) ? onPressedCallback : null
      )
    );
  }

  Widget _buildTextFormField({
    required String label, String? Function(String?)? validator, void Function(String)? onChanged,
    String? initialValue, bool obscureText = false
  }) {
    final InputDecoration inputDecoration = new InputDecoration(labelText: label);
    
    return new TextFormField(
      decoration: inputDecoration, validator: validator, autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged, initialValue: initialValue, obscureText: obscureText
    );
  }
  
  Widget _buildForgotPasswordButton() => WURL(text: "Forgot Password?", onPressed: () {});
}