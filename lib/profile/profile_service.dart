import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/profile/set_profile_dto.dart';
import 'profile_dao.dart';
import 'profile_dto.dart';

@singleton
class ProfileService {
  bool isValidUsername(final String username) {
    if(username.length < 6 || username.length > 20)
      return false;

    return !username.contains("^[A-Za-z0-9_]");
  }

  Future<void> createProfile(final String userId, final String username) async {
    await setProfile(new SetProfileDTO(userId, username, "", dpURL: _defaultDpURL));
  }

  Future<void> setProfile(final SetProfileDTO profile) async {
    final QuerySnapshot querySnapshot = await getProfileCollection()
    .where(_usernameField, isEqualTo: profile.username)
    .get();

    if(querySnapshot.size == 1 && querySnapshot.docs[0].get(_userIdField) != profile.userId)
      throw new UsernameAlreadyExistsError();

    final ProfileDAO profileDAO = new ProfileDAO(profile.userId);
    profileDAO.setUsername(profile.username);    
    profileDAO.setBio(profile.bio);
    
    final String dpURL;
    if(profile.dpURL != null)
      dpURL = profile.dpURL!;
    else {
      dpURL = await _uploadDPToStorage( profile.userId, new File(profile.dpPath!) );      
    }

    profileDAO.setDpURL(dpURL);


    await profileDAO.writeToDatabase();
  }

  Future<String> _uploadDPToStorage(final String userId, final File imageFile) async {
    final TaskSnapshot taskSnapshot = await FirebaseStorage.instance.ref()
    .child("profile")
    .child(userId)
    .child("dp.png")
    .putFile(imageFile);

    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<ProfileDTO?> getProfile(final String userId) async {
    final ProfileDAO profileDAO = new ProfileDAO(userId);
    await profileDAO.readFromDatabase();

    return _mapProfileDAOToDTO(profileDAO);
  }

  Future<ProfileDTO?> getProfileWithUsername(final String username) async {
    final QuerySnapshot querySnapshot = await getProfileCollection()
    .where(_usernameField, isEqualTo: username)
    .get();

    if(querySnapshot.size > 1)
      throw new MoreThanOneUserWithSameUsernameError();

    if(querySnapshot.size == 0)
      return null;

    final String userId = querySnapshot.docs[0].get(_userIdField);

    final ProfileDAO profileDAO = ProfileDAO(userId);
    await profileDAO.readFromDatabase();

    return _mapProfileDAOToDTO(profileDAO);
  }

  Stream<ProfileDTO> getProfileStream(final String userId) {
    return getProfileCollection().doc(userId).snapshots().map(_mapDocumentSnapshotToDTO);
  }

  Future<BuiltList<ProfileDTO>> getSearchResults(final String userId, final String searchText) async {
    final QuerySnapshot querySnapshot = await getProfileCollection()    
    .where("username", isGreaterThanOrEqualTo: searchText)
    .get();
    
    final List<ProfileDTO> users = querySnapshot.docs.map((e) => _mapDocumentSnapshotToDTO(e)).toList();

    users.removeWhere((e) => e.userId == userId);

    return users.toBuiltList();
  }

  ProfileDTO _mapDocumentSnapshotToDTO(final DocumentSnapshot snapshot) {
    return ProfileDTO(snapshot.id, snapshot.get("username"), snapshot.get("bio"), snapshot.get("dp_url"));
  }

  ProfileDTO _mapProfileDAOToDTO(final ProfileDAO profileDAO) {
    return new ProfileDTO(
      profileDAO.getUserId(), profileDAO.getUsername(), profileDAO.getBio(), profileDAO.getDpURL()
    );
  }  

  CollectionReference getProfileCollection() => _firestore().collection(_profileCollection);

  FirebaseFirestore _firestore() => FirebaseFirestore.instance;



  static const String _profileCollection = "profile";
  static const String _userIdField = 'user_id';
  static const String _usernameField = "username";

  static const String _defaultDpURL = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
}

class DTOAndDAOUsernamesNotMatchingError extends Error {}
class MoreThanOneUserWithSameUsernameError extends Error {}
class UsernameAlreadyExistsError extends Error {}
