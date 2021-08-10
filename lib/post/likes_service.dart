import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LikesService {
  Future<bool> likedBy(final String postId, final String userId) async {
    final DocumentSnapshot documentSnapshot = await _postCollection()
    .doc(postId).get();

    final List<String> likes = <String>[...documentSnapshot.get("likes")];    

    return likes.contains(userId);
  }

  Future<void> likePost(final String postId, final String userId) async {
    final DocumentSnapshot documentSnapshot = await _postCollection().doc(postId).get();

    final List<String> likes = <String>[...documentSnapshot.get("likes")];

    if(likes.contains(userId))
      throw new LikeAlreadyExistsError();

    likes.add(userId);

    await _postCollection().doc(postId).update({"likes" : likes});
  }

  Future<void> unlikePost(final String postId, final String userId) async {
    final DocumentSnapshot documentSnapshot = await _postCollection().doc(postId).get();

    final List<String> likes = <String>[...documentSnapshot.get("likes")];

    if(!likes.contains(userId))
      throw new LikeDoesntExistError();

    likes.remove(userId);

    await _postCollection().doc(postId).update({"likes" : likes});
  }  

  CollectionReference _postCollection() => firestore().collection("post");

  FirebaseFirestore firestore() => FirebaseFirestore.instance;
}

class LikeAlreadyExistsError extends Error {}
class LikeDoesntExistError extends Error {}