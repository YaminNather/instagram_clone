import 'package:instagram_ui_clone/post/post.dart';

class SearchPagePostDTO {
  const SearchPagePostDTO(this.userId, this.mediaType, this.mediaURL);


  final String userId;
  final MediaType mediaType;
  final String mediaURL;
}