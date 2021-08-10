import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_ui_clone/profile/profile.dart';

@lazySingleton
class AuthenticationService {
  const AuthenticationService(this._profileService);

  bool isValidEmail(final String email) {
    final RegExp specialCharactersRegex = new RegExp(r"[^A-Za-z0-9]");

    if(email.contains(new RegExp(r"[^A-Za-z0-9_@\.]")))
      return false;

    if(!email.contains("@"))
      return false;

    final List<String> splitEmail = email.split("@");
    if(splitEmail.length != 2)
      return false;
    
    final String prefix = email[0];
    if(prefix.startsWith(specialCharactersRegex) || prefix[prefix.length - 1].contains(specialCharactersRegex))
      return false;            

    final String domain = email[1];
    if(domain.startsWith(specialCharactersRegex) || domain[prefix.length - 1].contains(specialCharactersRegex))
      return false;

    return !domain.contains(new RegExp(r"\."));
  }

  bool isValidPassword(final String password) {
    return password.length >= 6 && password.length <= 15;
  }

  bool isValidUsername(final String username) {
    if(username.contains(new RegExp(r"[^A-Za-z0-9_]")))
      return false;

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

  Future<void> updateCurrentUsersPassword(final String oldPassword, final String newPassword) async {
    final User user = (await getCurrentUser())!;

    await auth().signInWithEmailAndPassword(email: user.email!, password: oldPassword);
    await user.updatePassword(newPassword);
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