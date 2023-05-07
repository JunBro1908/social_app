import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/user.dart' as model;
import 'package:social_app/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetail() async {
    // firebase itself user
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // sign up
  // we store user information using async, thus must use future type
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Error occurred';
    try {
      // should not be null value in it.
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // method of email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user to database : collection > doc > set data (overwride)
        model.User user = model.User(
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl,
            uid: cred.user!.uid,
            username: username);

        // set firestore collection user id as uid o/w add can be alternative option(random collection user id)
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
              // {
              //   'username': username,
              //   'uid': cred.user!.uid,
              //   'email': email,
              //   'bio': bio,
              //   'followers': [],
              //   'following': [],
              //   'photoUrl': photoUrl,
              // },
            );

        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'Please check the email format';
      } else if (e.code == 'weak-password') {
        res = 'Please be sure to enter your password more than 6';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // log in function
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No Info : Please Sign Up first';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong PW : Please recheck your password';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
