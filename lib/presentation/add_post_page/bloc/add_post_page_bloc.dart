import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/authentication/authentication_service.dart';
import 'package:instagram_ui_clone/post/post.dart';

part 'add_post_page_event.dart';
part 'add_post_page_state.dart';

@injectable
class AddPostPageBloc extends Bloc<AddPostPageEvent, AddPostPageState> {
  AddPostPageBloc(this._authenticationService, this._postService) : super(const InitialState());

  @override
  Stream<AddPostPageState> mapEventToState(AddPostPageEvent event) async* {
    if(event is ClickedPickMediaButtonEvent)
      yield* onClickedPickMediaButtonEvent(event);
  }

  Stream<AddPostPageState> onClickedPickMediaButtonEvent(final ClickedPickMediaButtonEvent event) async* {
    final XFile? mediaXFile = await _pickMedia(event.mediaToPick, event.imageSource);

    if(mediaXFile == null)
      return;

    final String caption = await _getCaptionFromDialog(event.pageContext);    
    final String userId = await _getCurrentUsersId();    

    yield const LoadingState();
    
    try {
      UploadPostDTO post = new UploadPostDTO(
        userId, event.mediaToPick, mediaXFile.path, caption, DateTime.now()
      );
      await _postService.upload(post);

      _showSnackbarOnUpload(event.pageContext, true);
    }
    catch(e) {
      _showSnackbarOnUpload(event.pageContext, false);
    }
    
    yield const InitialState();
  } 

  Future<XFile?> _pickMedia(final MediaType media, final ImageSource imageSource) async {
    final ImagePicker picker = new ImagePicker();

    final XFile? imageXFile;
    if(media == const ImageMediaType())
      imageXFile = await picker.pickImage(source: imageSource);
    else
      imageXFile = await picker.pickVideo(source: imageSource);

    return imageXFile;
  }

  void _showSnackbarOnUpload(final BuildContext pageContext, final bool success) {
    final String message = (success) ? "Uploaded post" : "Failed to upload post";

    ScaffoldMessenger.of(pageContext).showSnackBar( SnackBar(content: Text(message)) );
  }

  Future<String> _getCaptionFromDialog(final BuildContext pageContext) async {
    String r = "";

    Widget dialogBuilder(final BuildContext dialogContext) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (text) => r = text, 
                decoration: const InputDecoration(labelText: "Caption")
              ),

              const SizedBox(width: 16.0), 

              ElevatedButton(child: const Text("Post"), onPressed: () => Navigator.pop(dialogContext))
            ],
          ),
        )
      );
    }

    await showDialog(context: pageContext, builder: dialogBuilder);

    return r;
  }

  Future<String> _getCurrentUsersId() async {
    final User currentUser = (await _authenticationService.getCurrentUser())!;
    
    return currentUser.uid;
  }



  final AuthenticationService _authenticationService;
  final PostService _postService;
}