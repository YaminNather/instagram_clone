import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_ui_clone/presentation/change_password_page/bloc/change_password_page_bloc.dart';

class WChangePasswordPage extends StatefulWidget {
  const WChangePasswordPage({ Key? key }) : super(key: key);

  @override
  _WChangePasswordPageState createState() => _WChangePasswordPageState();
}

class _WChangePasswordPageState extends State<WChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordPageBloc>(
      create: (context) => _bloc,
      child: Scaffold(appBar: _buildAppBar(), body: _buildBody())
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Change Password"), 
      actions: <Widget>[
        _buildCheckmarkButton()
      ]
    );
  }

  Widget _buildCheckmarkButton() {
    return BlocBuilder<ChangePasswordPageBloc, ChangePasswordPageState>(
      builder: (context, state) {        
        final void Function()? onPressedCallback;
        if(state is LoadingState)
          onPressedCallback = null;
        else if(state is LoadedState) {
          if(state.checkmarkEnabled)
            onPressedCallback = () => _bloc.add(new ClickedCheckmarkButtonEvent(context));
          else
            onPressedCallback = null;
        }
        else 
          onPressedCallback = null;                  

        return IconButton(icon: const Icon(EvaIcons.checkmarkOutline), onPressed: onPressedCallback);
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ChangePasswordPageBloc, ChangePasswordPageState>(
      builder: (context, state) {
        if(state is LoadingState)
          return const Center(child: CircularProgressIndicator.adaptive());

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _bloc.formKey,
            onChanged: () => _bloc.add(const FormChangedEvent()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
                _buildCurrentPasswordField(),
    
                const SizedBox(height: 16.0),
    
                _buildNewPasswordField(),
    
                const SizedBox(height: 16.0),
                
                _buildError()               
              ]
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentPasswordField() {
    String? validatorCallback(String? value) {
      return (_bloc.currentPasswordValidator()) ? null : "Enter valid password";
    }

    return _buildTextFormField(
      controller: _bloc.currentPasswordController, label: "Current Password", validator: validatorCallback,
      autofocus: true
    );
  }

  Widget _buildNewPasswordField() {
    String? validatorCallback(String? value) {
      return (_bloc.newPasswordValidator()) ? null : "Password is the invalid or the same as current password";
    }

    return _buildTextFormField(
      controller: _bloc.newPasswordController, label: "New Password", validator: validatorCallback
    );
  }

  Widget _buildError() {
    final ThemeData theme = Theme.of(context);
    final LoadedState loadedState = _bloc.state as LoadedState;

    return Text(loadedState.error, style: TextStyle(color: theme.errorColor));
  }

  Widget _buildTextFormField({
    TextEditingController? controller, String? label, void Function(String)? onChanged, 
    String? Function(String?)? validator, bool autofocus = false
  }) {
    InputDecoration deocoration = new InputDecoration(labelText: label);

    return TextFormField(
      controller: controller, decoration: deocoration, onChanged: onChanged, validator: validator, 
      obscureText: true, autofocus: autofocus
    );
  }



  final ChangePasswordPageBloc _bloc = new ChangePasswordPageBloc();
}