import 'package:equatable/equatable.dart';
import 'package:instagram_ui_clone/post/post.dart';

class PostDTO extends Equatable {
  const PostDTO(this.postId, this.userData, this.mediaType, this.imageURI, this.caption, this.dateTime);

  @override  
  List<Object?> get props => [postId, userData, mediaType, imageURI, caption, dateTime];



  final String postId;
  final UserData userData;
  final MediaType mediaType;
  final String imageURI;
  final String caption;
  final DateTime dateTime;
}

class UserData extends Equatable {
  const UserData(this.userId, this.username, this.dpURL);

  @override  
  List<Object?> get props => [userId, username, dpURL];



  final String userId;
  final String username;
  final String dpURL;
}