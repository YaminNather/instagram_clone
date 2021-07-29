import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileDAO {
  ProfileDAO(this._userId);

  Future<void> readFromDatabase() async {
    final DocumentSnapshot documentSnapshot = await _documentReference().get();

    _username = documentSnapshot.get("username");
    _bio = documentSnapshot.get("bio");
    _dpURL = documentSnapshot.get("dp_url");    
  }

  Future<void> writeToDatabase() async {
    await _documentReference().set(
      <String, dynamic> {
        "user_id" : _userId,
        "username" : _username,
        "bio" : _bio,
        "dp_url" : _dpURL
      }
    );
  }

  DocumentReference _documentReference() {
    return FirebaseFirestore.instance.collection("profile").doc(_userId);
  }

  String getUserId() {
    return _userId;
  }

  String getUsername() {
    return _username;
  }

  void setUsername(final String value) {
    _username = value;
  }

  String getBio() {
    return _bio;
  }

  void setBio(final String value) {
    _bio = value;
  }
  
  String getDpURL() {
    return _dpURL;
  }

  void setDpURL(final String value) {
    _dpURL = value;
  }


  final String _userId;  
  String _username = "";
  String _bio = "";
  String _dpURL = "";
}