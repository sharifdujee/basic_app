
import 'dart:developer';

import 'package:bloc_auth/user_repository/model/user.dart';
import 'package:bloc_auth/user_repository/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserRepo implements UserRepository{
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('user');

   FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
}): _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;


  @override
  // TODO: implement user
  Stream<User?> get user{
    return _firebaseAuth.authStateChanges().map((firebaseUser){
      return firebaseUser;
    });
  }


  @override
  Future<void> signIn(String email, String password) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);


    }
    catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    // TODO: implement signUp
    try{
     UserCredential user = await  _firebaseAuth.createUserWithEmailAndPassword(email: myUser.email, password: password);

     myUser = myUser.copyWith(
       userId: user.user!.uid,
     );
     return myUser;


    }

    catch(e){
      log(e.toString());
      rethrow;
    }

  }
  @override
  Future<void> setUserData(MyUser myUser) async {
    try{
      await userCollection.doc(myUser.userId).set(myUser.toEntity().toDocument());

    }
    catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }


}