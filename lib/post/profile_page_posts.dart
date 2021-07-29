import 'package:equatable/equatable.dart';
import 'post_service.dart';

class ProfilePagePost extends Equatable {
  const ProfilePagePost(this.mediaType, this.uri);

  @override  
  List<Object?> get props => [mediaType, uri];


  final MediaType mediaType;
  final String uri;
}

class ProfilePagePosts extends Equatable {
  const ProfilePagePosts._(this._imageURLs);

  factory ProfilePagePosts(final List<ProfilePagePost> profilePagePosts) {
    return new ProfilePagePosts._(new List<ProfilePagePost>.from(profilePagePosts));
  }

  ProfilePagePost operator[](int index) => _imageURLs[index];

  int get length => _imageURLs.length;

  @override  
  List<Object?> get props => [..._imageURLs];



  final List<ProfilePagePost> _imageURLs;
}