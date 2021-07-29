import 'package:instagram_ui_clone/post/post_service.dart';

class UploadPostDTO {
  UploadPostDTO(this.userId, this.mediaType, this.imageURI, this.caption, this.dateTime);


  final String userId;
  final MediaType mediaType;
  final String imageURI;
  final String caption;
  final DateTime dateTime;
}