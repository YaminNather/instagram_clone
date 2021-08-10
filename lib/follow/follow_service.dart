import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FollowService {
  Future<bool> followedBy(final String followee, final String follower) async {
    final QuerySnapshot querySnapshot = await _getFollowingCollection()
    .where("followee", isEqualTo: followee)
    .where("follower", isEqualTo: follower)
    .get();
    
    return querySnapshot.size == 1;
  }

  Future<void> follow(final String followee, final String follower) async {
    if(await followedBy(followee, follower))
      throw new AlreadyFollowingError();    

    await _getFollowingCollection().add({"followee" : followee, "follower" : follower});
  }

  Future<void> unfollow(final String followee, final String follower) async {
    final QuerySnapshot querySnapshot = await _getFollowingCollection()
    .where("followee", isEqualTo: followee)
    .where("follower", isEqualTo: follower)
    .get();

    if(querySnapshot.size != 1)
      throw new NotFollowingError();

    await _getFollowingCollection().doc(querySnapshot.docs[0].id).delete();
  }

  Future<BuiltList<String>> getFollowers(final String userId) async {
    final QuerySnapshot querySnapshot = await _getFollowingCollection()
    .where("followee", isEqualTo: userId)
    .get();

    try{
      return querySnapshot.docs.map<String>((e) => e.get("follower")).toBuiltList();
    }
    catch(e) {
      return BuiltList<String>();
    }
  }

  Stream<BuiltList<String>> getFollowingStream(final String userId) {
    final Stream<QuerySnapshot> snapshotsStream = _getFollowingCollection()    
    .where("follower", isEqualTo: userId)
    .snapshots();

    BuiltList<String> mapperFunction(QuerySnapshot e) {
      return e.docs.map<String>((e) => e.get("followee")).toBuiltList();
    }

    return snapshotsStream.map<BuiltList<String>>(mapperFunction);  
  }

  Stream<BuiltList<String>> getFollowersStream(final String userId) {
    final Stream<QuerySnapshot> snapshotsStream = _getFollowingCollection()    
    .where("followee", isEqualTo: userId)
    .snapshots();

    BuiltList<String> mapperFunction(QuerySnapshot e) {
      return e.docs.map<String>((e) => e.get("follower")).toBuiltList();
    }

    return snapshotsStream.map<BuiltList<String>>(mapperFunction);
  }

  CollectionReference _getFollowingCollection() => _firestore().collection("following");

  FirebaseFirestore _firestore() => FirebaseFirestore.instance;
}

class AlreadyFollowingError extends Error {}
class NotFollowingError extends Error {}