import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/profile/profile.dart';

@lazySingleton
class AuthenticationService {
  const AuthenticationService(this._profileService);

  bool isValidEmail(final String email) {
    return email.contains("@");
  }

  bool isValidPassword(final String password) {
    return true;
  }

  bool isValidUsername(final String username) {
    return _profileService.isValidUsername(username);
  }

  Future<User?> getCurrentUser() async {
    return auth().currentUser;
  }

  Future<User?> signUpWithEmailAndPassword(String username, String email, String password) async {
    if(await usernameExists(username))
      throw new UserWithUsernameAlreadyExistsException();

    final UserCredential cred = await auth().createUserWithEmailAndPassword(email: email, password: password);

    final User user = cred.user!;
    await getUserCollection().doc(user.uid).set(
      <String, dynamic>{userIdField : user.uid, emailField : email}
    );

    await _profileService.createProfile(user.uid, username);
  }

  Future<User?> signInWithUsernameAndPassword(String username, String password) async {
    if(!( await usernameExists(username) ))
      throw new UsernameDoesntExistException();

    final String email = await getEmailAssociatedWithUsername(username);
    await signInWithEmailAndPassword(email, password);
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    await auth().signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() => auth().signOut();

  Future<String> getEmailAssociatedWithUsername(final String username) async {
    final ProfileDTO? profileDTO = await _profileService.getProfileWithUsername(username);
    if(profileDTO == null)
      throw UsernameDoesntExistException();

    final String userId = profileDTO.userId;

    final DocumentSnapshot documentSnapshot = await getUserCollection().doc(userId).get();
    return documentSnapshot.get(emailField);
  }

  Future<bool> usernameExists(final String username) async {
    final ProfileDTO? profile = await _profileService.getProfileWithUsername(username);
    
    return profile != null;
  }

  Future<String> getUsername(final String userId) async {
    final DocumentSnapshot documentSnapshot = await getUserCollection().doc(userId).get();

    if(documentSnapshot.exists == false)
      throw new UserIdDoesntExistException();

    return await documentSnapshot.get("username");
  }

  CollectionReference getUserCollection() => firestore().collection(userCollection);

  CollectionReference getProfileCollection() => firestore().collection(profileCollection);

  FirebaseAuth auth() => FirebaseAuth.instance;
  FirebaseFirestore firestore() => FirebaseFirestore.instance;




  final ProfileService _profileService;

  static const String userCollection = "user";
  static const String userIdField = 'user_id';
  static const String emailField = "email";
  static const String profileCollection = "profile";
  static const String usernameField = "username";
}

class MoreThanOneUserWithSameUsernameError extends Error {}
class UserWithUsernameAlreadyExistsException implements Exception {}
class UsernameDoesntExistException implements Exception {}
class UserIdDoesntExistException implements Exception {}