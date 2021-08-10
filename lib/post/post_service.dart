import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/post/profile_page_posts.dart';
import 'package:instagram_ui_clone/post/search_page_dto.dart';
import 'package:instagram_ui_clone/profile/profile.dart';
import 'likes.dart';
import 'upload_post_dto.dart';
import 'post_dto.dart';

@lazySingleton
class PostService {
  PostService(this._profileService);

  Future<void> upload(final UploadPostDTO post) async {
    final Map<String, dynamic> json = <String, dynamic>{
      "user_id" : post.userId,      
      "caption" : post.caption,
      "time" : Timestamp.fromDate(post.dateTime),
      "media_type" : post.mediaType.value,
      "likes" : <String>[]
    };
    final DocumentReference documentReference = await _postCollection().add(json);

    final FirebaseStorage storage = FirebaseStorage.instance;
    final TaskSnapshot task = await storage.ref()
    .child("post")
    .child(documentReference.id)
    .child("image")
    .putFile(new File(post.imageURI));

    String imageDownloadURL = await task.ref.getDownloadURL();

    documentReference.update({"image_url" : imageDownloadURL});
  }

  Future<List<PostDTO>> getForUsersFeed(final String userId) async {
    final QuerySnapshot querySnapshot = await _postCollection().where("user_id", isNotEqualTo: userId).get();


    final List<PostDTO> r = [];    
    for(final DocumentSnapshot docSnapshot in querySnapshot.docs)
      r.add(await _buildPostDTOFromDocumentSnapshot(docSnapshot));    

    return r;
  }

  Stream<List<PostDTO>> getStreamForUsersFeed(final String userId) {
    Stream<QuerySnapshot> querySnapshotsStream = _postCollection()
    .where('user_id', isNotEqualTo: userId)
    .snapshots();

    final Stream<List<PostDTO>> r = querySnapshotsStream.asyncMap<List<PostDTO>>(
      (querySnapshot) async {
        final List<PostDTO> posts = [];        
        for(final DocumentSnapshot docSnapshot in querySnapshot.docs)
          posts.add(await _buildPostDTOFromDocumentSnapshot(docSnapshot));

        return posts;
      }
    );

    return r;
  }

  Future<PostDTO> _buildPostDTOFromDocumentSnapshot(final DocumentSnapshot docSnapshot) async {
    final PostDTO postDTO = new PostDTO(
      docSnapshot.id, 
      await _getUserData(docSnapshot.get("user_id")), 
      MediaType.fromValue(docSnapshot.get("media_type")), 
      docSnapshot.get("image_url"), 
      docSnapshot.get("caption"),
      (docSnapshot.get("time") as Timestamp).toDate(),
      new Likes((docSnapshot.get("likes") as List<dynamic>).map((e) => e as String).toList())
    );

    return postDTO;
  }

  Future<UserData> _getUserData(final String userId) async {
    final ProfileDTO profile = (await _profileService.getProfile(userId))!;

    return new UserData(userId, profile.username, profile.dpURL);
  }

  Future<ProfilePagePosts> getForProfilePage(final String userId) async {
    final QuerySnapshot querySnapshot = await _postCollection()
    .where("user_id", isEqualTo: userId)
    .orderBy("time", descending: true)
    .get();

    ProfilePagePost mapper(final DocumentSnapshot documentSnapshot) {
      final MediaType mediaType = MediaType.fromValue(documentSnapshot.get("media_type"));
      final String uri = documentSnapshot.get("image_url");
      
      return new ProfilePagePost(mediaType, uri);
    }

    final List<ProfilePagePost> imageURLs = querySnapshot.docs.map<ProfilePagePost>(mapper).toList();
    
    return ProfilePagePosts(imageURLs);
  }

  Future<BuiltList<SearchPagePostDTO>> getForSearchPage(final String userId) async {
    final QuerySnapshot querySnapshot = await _postCollection()
    .where("user_id", isNotEqualTo: userId)
    .limit(10)
    .get();

    SearchPagePostDTO mapper(final DocumentSnapshot documentSnapshot) {
      return new SearchPagePostDTO(
        documentSnapshot.get("user_id"),
        new MediaType.fromValue(documentSnapshot.get("media_type")),
        documentSnapshot.get("image_url")        
      );
    }

    return querySnapshot.docs.map(mapper).toBuiltList();
  }

  CollectionReference _postCollection() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection("post");
  }

  
  
  final ProfileService _profileService;
}


abstract class MediaType extends Equatable {
  const MediaType._(this.value);    
  
  factory MediaType.fromValue(String value) {
    switch(value) {
      case "image": return const ImageMediaType();

      case "video" : return const VideoMediaType();

      default : throw new Error();
    }
  }

  @override
  List<Object> get props => [value];



  final String value;
}

class ImageMediaType extends MediaType {
  const ImageMediaType() : super._("image");
}

class VideoMediaType extends MediaType {
  const VideoMediaType() : super._("video");
}