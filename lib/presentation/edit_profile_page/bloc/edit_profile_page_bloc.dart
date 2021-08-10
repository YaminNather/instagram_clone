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
import 'package:instagram_ui_clone/presentation/utils/widget_utils.dart';
import '../../../authentication/authentication_service.dart';
import '../../../profile/profile.dart';
import "package:image_cropper/image_cropper.dart";

part 'edit_profile_page_event.dart';
part 'edit_profile_page_state.dart';

@injectable
class EditProfilePageBloc extends Bloc<EditProfilePageEvent, EditProfilePageState> {
  EditProfilePageBloc(this._authenticationService, this._profileService) : super(const LoadingState());

  @override
  Stream<EditProfilePageState> mapEventToState(EditProfilePageEvent event) async* {
    if(event is WidgetLoadedEvent)
      yield* onWidgetLoadedEvent(event);
    
    else if(event is FormChangedEvent)
      yield* onFormChangedEvent(event);
    
    else if(event is ClickedCheckmarkButtonEvent)
      yield* onClickedCheckmarkButtonEvent(event);  

    else if(event is ClickedChangeDPEvent)
      yield* onClickedChangeDPButtonEvent(event);

    else if(event is ChangedDPEvent)
      yield* onChangedDPEvent(event);

    else if(event is ClickedChangePasswordEvent)
      yield* onClickedChangePasswordEvent(event);
  }

  Stream<EditProfilePageState> onWidgetLoadedEvent(WidgetLoadedEvent event) async* {
    final User user = (await _authenticationService.getCurrentUser())!;
    
    final ProfileDTO profile = (await _profileService.getProfile(user.uid))!;

    usernameController.text = profile.username;
    bioController.text = profile.bio;    

    yield new InputState(true, "", profile.dpURL, "");
  }

  Stream<EditProfilePageState> onFormChangedEvent(final FormChangedEvent event) async* {
    final InputState inputState = state as InputState;
    
    yield inputState.copyWith(checkmarkEnabled: formKey.currentState!.validate());
  }

  Stream<EditProfilePageState> onClickedCheckmarkButtonEvent(ClickedCheckmarkButtonEvent event) async* {
    final InputState inputState = state as InputState;

    yield const LoadingState();

    final User currentUser = (await _authenticationService.getCurrentUser())!;    
    final SetProfileDTO profile = new SetProfileDTO(
      currentUser.uid, usernameController.text, bioController.text,
      dpURL: (inputState.dpPath.isEmpty) ? inputState.dpURL : null, 
      dpPath: (inputState.dpPath.isNotEmpty) ? inputState.dpPath : null
    );
    
    try {
      await _profileService.setProfile(profile);      
      
      showSnackBarWithText(event.context, "Profile updated");
      Navigator.pop(event.context);
    }
    on UsernameAlreadyExistsError {
      showSnackBarWithText(event.context, "Username already exists");
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

  Stream<EditProfilePageState> onClickedChangePasswordEvent(final ClickedChangePasswordEvent event) async* {    
    await Navigator.pushReplacementNamed(event.pageContext, "Change Password Page");
  }

  Future<void> _pickThumbnailFromImagePicker(ImageSource source) async {
    final ImagePicker imagePicker = new ImagePicker();

    final XFile? pickedImageXFile = await imagePicker.pickImage(source: source, );
    if(pickedImageXFile == null)
      return;

    final File? croppedImageFile = await ImageCropper.cropImage(sourcePath: pickedImageXFile.path);
    final String imagePath;
    if(croppedImageFile == null)
      imagePath = pickedImageXFile.path;
    else
      imagePath = croppedImageFile.path;
 
    add(new ChangedDPEvent(imagePath));
  }

  Stream<EditProfilePageState> onChangedDPEvent(final ChangedDPEvent event) async* {
    print("Changed DP");
    
    final InputState previousInputState = state as InputState;

    yield previousInputState.copyWith(dpPath: event.path);
  }  

  bool usernameValidator(final String value) {
    return _authenticationService.isValidUsername(value);
  }


  final AuthenticationService _authenticationService;
  final ProfileService _profileService;

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();  
  final TextEditingController bioController = new TextEditingController();

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
}
