import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../authentication/authentication_service.dart';
import '../../../profile/profile.dart';

part 'edit_profile_page_event.dart';
part 'edit_profile_page_state.dart';

@injectable
class EditProfilePageBloc extends Bloc<EditProfilePageEvent, EditProfilePageState> {
  EditProfilePageBloc(this._authenticationService, this._profileService) : super(const LoadingState());

  @override
  Stream<EditProfilePageState> mapEventToState(EditProfilePageEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* onWidgetLoadedEvent(event);
    
    if(event is ClickedCheckmarkButtonEvent)
      yield* onClickedCheckmarkButtonEvent(event);

    else if(event is ChangedUsernameEvent)
      yield* onChangedUsernameEvent(event);

    else if(event is ChangedBioEvent)
      yield* onChangedBioEvent(event);

    else if(event is ClickedChangeDPEvent)
      yield* onClickedChangeDPButtonEvent(event);

    else if(event is ChangedDPEvent)
      yield* onChangedDPEvent(event);
  }

  Stream<EditProfilePageState> onWidgetLoadedEvent(WidgetLoadedEvent event) async* {
    final User user = (await _authenticationService.getCurrentUser())!;
    
    final ProfileDTO profile = (await _profileService.getProfile(user.uid))!;

    yield new InputState(new TextWithError(profile.username, ""), profile.bio, "", profile.dpURL, "");
  }

  Stream<EditProfilePageState> onClickedCheckmarkButtonEvent(ClickedCheckmarkButtonEvent event) async* {
    final InputState inputState = state as InputState;

    yield const LoadingState();

    final User currentUser = (await _authenticationService.getCurrentUser())!;
    print("CustomLog: uid = ${currentUser.uid}");
    final SetProfileDTO profile = new SetProfileDTO(
      currentUser.uid, inputState.username.text, inputState.bio,
      dpURL: inputState.dpPath.isEmpty ? inputState.dpURL : null, 
      dpPath: inputState.dpPath.isNotEmpty ? inputState.dpPath : null
    );
    
    try {
      await _profileService.setProfile(profile);
      
      Navigator.pop(event.context);
    }
    on UsernameAlreadyExistsError {
      yield inputState.copyWith(error: "Username already exists");
    }

  }
  
  Stream<EditProfilePageState> onClickedChangeDPButtonEvent(final ClickedChangeDPEvent event) async* {
    Widget buildModalSheet(BuildContext context) {
      return new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(EvaIcons.fileOutline),
            title: const Text("Gallery"), 
            onTap: () async => _pickThumbnailFromImagePicker(ImageSource.gallery)
          ),
          
          ListTile(
            leading: const Icon(EvaIcons.camera),
            title: const Text("Camera"), 
            onTap: () => _pickThumbnailFromImagePicker(ImageSource.camera)
          )
        ]
      );
    }
    
    await showModalBottomSheet(context: event.context, builder: buildModalSheet);
  }

  Future<void> _pickThumbnailFromImagePicker(ImageSource source) async {
    final ImagePicker imagePicker = new ImagePicker();

    final XFile? pickedImageXFile = await imagePicker.pickImage(source: source);
    if(pickedImageXFile == null)
      return;

    add(new ChangedDPEvent(pickedImageXFile.path));
  }

  Stream<EditProfilePageState> onChangedUsernameEvent(final ChangedUsernameEvent event) async* {
    final InputState inputState = state as InputState;

    final String error;
    if(event.value.isEmpty || _profileService.isValidUsername(event.value))
      error = "";
    else
      error = "Pls input valid username";
    
    yield inputState.copyWith(username: new TextWithError(event.value, error));
  }

  Stream<EditProfilePageState> onChangedBioEvent(final ChangedBioEvent event) async* {
    final InputState inputState = state as InputState;    
    
    yield inputState.copyWith(bio: event.value);
  }  

  Stream<EditProfilePageState> onChangedDPEvent(final ChangedDPEvent event) async* {
    print("Changed DP");
    
    final InputState previousInputState = state as InputState;

    yield previousInputState.copyWith(dpPath: event.path);
  }


  final AuthenticationService _authenticationService;
  final ProfileService _profileService;
}
