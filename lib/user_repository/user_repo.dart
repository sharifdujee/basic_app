import 'package:bloc_auth/user_repository/model/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository{
  Stream<User?> get user;
  ///sign up
  Future<MyUser> signUp(MyUser myUser, String password);

  ///set user data

  Future<void> setUserData(MyUser user);

  /// sign in
 Future<void> signIn(String email, String password);

  Future<void> logOut();



}