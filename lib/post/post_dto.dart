import 'package:equatable/equatable.dart';
import 'package:instagram_ui_clone/post/post.dart';

import 'likes.dart';

class PostDTO extends Equatable {
  const PostDTO(
    this.postId, this.userData, this.mediaType, this.imageURI, this.caption, this.dateTime, this.likes
  );

  @override  
  List<Object?> get props => [postId, userData, mediaType, imageURI, caption, dateTime, likes];



  final String postId;
  final UserData userData;
  final MediaType mediaType;
  final String imageURI;
  final String caption;
  final DateTime dateTime;
  final Likes likes;
}

class UserData extends Equatable {
  const UserData(this.userId, this.username, this.dpURL);

  @override  
  List<Object?> get props => [userId, username, dpURL];



  final String userId;
  final String username;
  final String dpURL;
}