import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  signIn() async {
    var user = await _firebaseAuth.signInAnonymously();
    return user.user;
  }
}
