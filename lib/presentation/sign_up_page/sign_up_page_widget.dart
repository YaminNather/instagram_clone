import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../injector.dart';
import '../widgets/instagram_logo_widget.dart';
import '../utils/widget_utils.dart';
import 'bloc/sign_up_page_bloc.dart';

class WSignUpPage extends StatefulWidget {
  const WSignUpPage({ Key? key }) : super(key: key);

  @override
  _WSignUpPageState createState() => _WSignUpPageState();
}

class _WSignUpPageState extends State<WSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpPageBloc>(
      create: (context) => getIt<SignUpPageBloc>(),
      child: Provider<BuildContext>.value(
        value: context,
        child: Scaffold(appBar: AppBar(), body: _buildBody(context))
      )
    );
  }

  Widget _buildBody(final BuildContext context) {
    return BlocBuilder<SignUpPageBloc, SignUpPageState>(
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
                  children: [
                    _buildLogo(context),
    
                    const SizedBox(height: 32.0),
                    
                    _WForm(),
    
                    const SizedBox(height: 16.0),
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        const Expanded(child: const Divider()),
                        
                        const Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0), 
                          child: const Text("OR")
                        ),
    
                        const Expanded(child: const Divider())
                      ]
                    ),
    
                    const SizedBox(height: 4.0),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Have an account?"),
    
                        TextButton(
                          child: const Text(" Log in."), 
                          onPressed: () => Navigator.popAndPushNamed(context, "Sign In Page")
                        )
                      ]
                    )
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
}




class _WForm extends StatelessWidget {
  _WForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpPageBloc bloc = BlocProvider.of<SignUpPageBloc>(context);

    return Wrap(
      runSpacing: 16.0,
      children: <Widget>[
        _buildUsernameField(bloc),

        _buildEmailAddressField(bloc),

        _buildPasswordField(bloc),

        _buildConfirmPasswordField(bloc),

        _buildSignUpButton(context, bloc)          
      ]
    );
  }

  Widget _buildUsernameField(final SignUpPageBloc bloc) {
    final InputState state = bloc.state as InputState;
    final TextWithError username = state.username;
    
    void onChangedCallback(String value) {
      bloc.add(new ChangedUsernameEvent(value));
    }

    String? validatorCallback(String? text) {
      return (username.isValid()) ? null : username.error;
    }    

    return _buildTextFormField(
      label: "Username", initialValue: username.text, validator: validatorCallback,
      onChanged: onChangedCallback
    );
  }

  Widget _buildEmailAddressField(final SignUpPageBloc bloc) {
    final InputState state = bloc.state as InputState;
    final TextWithError emailAddress = state.emailAddress;
    
    void onChangedCallback(String value) {
      bloc.add(new ChangedEmailEvent(value));
    }

    String? validatorCallback(String? text) {
      return (emailAddress.isValid()) ? null : emailAddress.error;
    }    

    return _buildTextFormField(
      label: "Email", initialValue: emailAddress.text, validator: validatorCallback,
      onChanged: onChangedCallback
    );
  }

  Widget _buildPasswordField(final SignUpPageBloc bloc) {
    final InputState state = bloc.state as InputState;
    final TextWithError password = state.password;
    
    void onChangedCallback(String value) {
      bloc.add(new ChangedPasswordEvent(value));
    }

    String? validatorCallback(String? text) {
      return (password.isValid()) ? null : password.error;
    }    

    return _buildTextFormField(
      label: "Password", initialValue: password.text, validator: validatorCallback,
      onChanged: onChangedCallback, obscureText: true
    );
  }

  Widget _buildConfirmPasswordField(final SignUpPageBloc bloc) {
    final InputState state = bloc.state as InputState;
    final TextWithError confirmPassword = state.confirmPassword;
    
    void onChangedCallback(String value) {
      bloc.add(new ChangedConfirmPasswordEvent(value));
    }

    String? validatorCallback(String? text) {
      return (confirmPassword.isValid()) ? null : confirmPassword.error;
    }    
    
    return _buildTextFormField(
      label: "Confirm Password", initialValue: confirmPassword.text, validator: validatorCallback,
      onChanged: onChangedCallback, obscureText: true
    );
  }

  Widget _buildSignUpButton(final BuildContext context, final SignUpPageBloc bloc) {
    final InputState state = bloc.state as InputState;
    
    void onPressedCallback() {
      final BuildContext parentContext = Provider.of<BuildContext>(context, listen: false);

      bloc.add(new ClickedSignUpButtonEvent(parentContext));      
    }

    final bool buttonEnabled = state.emailAddress.isNotEmptyAndValid()
                               && state.password.isNotEmptyAndValid()
                               && state.confirmPassword.isNotEmptyAndValid();

    return SizedBox(      
      width: double.infinity, height: 50.0,
      child: ElevatedButton(child: const Text("Sign up"), 
      onPressed: (buttonEnabled) ?  onPressedCallback: null)
    );
  }

  Widget _buildTextFormField({
    required String label, String? initialValue, String? Function(String?)? validator, 
    void Function(String)? onChanged, bool obscureText = false
  }) {
    final InputDecoration inputDecoration = new InputDecoration(labelText: label);
    
    return new TextFormField(
      decoration: inputDecoration, initialValue: initialValue, validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction, onChanged: onChanged, obscureText: obscureText
    );
  }  
}