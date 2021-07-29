import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injector.dart';

import 'bloc/edit_profile_page_bloc.dart';

class WEditProfilePage extends StatefulWidget {
  WEditProfilePage({ Key? key }) : super(key: key);

  @override
  _WEditProfilePageState createState() => new _WEditProfilePageState(); 
}

class _WEditProfilePageState extends State<WEditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocProvider<EditProfilePageBloc>(
      create: (_) => bloc..add(const WidgetLoadedEvent()),
      child: Scaffold(appBar: _buildAppBar(), body: _buildBody(theme))
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Edit Profile"), 
      actions: <Widget>[
        _buildCheckmarkButton()
      ]
    );
  }

  Widget _buildCheckmarkButton() {
    return BlocBuilder<EditProfilePageBloc, EditProfilePageState>(
      builder: (context, state) {
        if(state is LoadingState)
          return const Center(child: const CircularProgressIndicator.adaptive());

        final InputState inputState = state as InputState;
        
        void onPressedCallback() {
          bloc.add(ClickedCheckmarkButtonEvent(context));
        }

        return IconButton(
          icon: const Icon(EvaIcons.checkmarkOutline), 
          onPressed: inputState.username.error.isEmpty ?  onPressedCallback : null
        );
      }
    );
  }

  Widget _buildBody(final ThemeData theme) {
    return BlocBuilder<EditProfilePageBloc, EditProfilePageState>(
      builder: (context, state) {
        if(state is LoadingState)
          return const Center(child: const CircularProgressIndicator.adaptive());

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildChangePhotoButton(theme),
    
                const SizedBox(height: 32.0),
    
                Wrap(
                  runSpacing: 8.0,
                  children: [
                    _buildUsernameField(),
                    
                    _buildBioField()
                  ],
                )
              ]
            ),
          )
        );
      },
    );
  }

  Widget _buildChangePhotoButton(final ThemeData theme) {
    return InkWell(
      onTap: () => bloc.add(new ClickedChangeDPEvent(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,  
      children: <Widget>[
          _buildDp(),

          const SizedBox(height: 8.0),

          Text("Change Profile Photo", style: theme.textTheme.headline6!.copyWith(color: Colors.blue))
        ]
      )
    );
  }

  Widget _buildDp() {
    final InputState inputState = bloc.state as InputState;
    if(inputState.dpPath.isEmpty)
      return new CircleAvatar(radius: 64.0, backgroundImage: NetworkImage(inputState.dpURL));
    else
      return new CircleAvatar(radius: 64.0, backgroundImage: FileImage(new File(inputState.dpPath)));
  }

  Widget _buildUsernameField() {
    final InputState inputState = bloc.state as InputState;

    void onChangedCallback(String text) {
      bloc.add(ChangedUsernameEvent(text));
    }

    String? validatorCallback(String? text) {
      return inputState.username.error.isEmpty ? null : inputState.username.error;
    }

    return _buildTextFormField(
      label: "Username", initialValue: inputState.username.text, onChanged: onChangedCallback, 
      validator: validatorCallback
    );
  }

  Widget _buildBioField() {
    void onChangedCallback(String text) {
      bloc.add(ChangedBioEvent(text));
    }

    final InputState inputState = bloc.state as InputState;

    return _buildTextFormField(
      label: "Bio", initialValue: inputState.bio, onChanged: onChangedCallback, maxLines: null
    );
  }

  Widget _buildTextFormField({
    String? label, String? initialValue, void Function(String)? onChanged, 
    String? Function(String?)? validator, int? maxLines = 1
  }) {
    InputDecoration deocoration = new InputDecoration(labelText: label);

    return TextFormField(
      decoration: deocoration, initialValue: initialValue, onChanged: onChanged, validator: validator,
      maxLines: maxLines
    );
  }  


  final EditProfilePageBloc bloc = getIt<EditProfilePageBloc>();
}