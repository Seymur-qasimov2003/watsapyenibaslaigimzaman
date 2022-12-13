import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:watsapcloneee/core/services/auth_service.dart';

import 'base_model.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = AuthService();

  Future<void> signIn(String userName) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    if (userName != null) {
      var user = await _authService.signIn();
      await _firestore.collection('profile').doc(user.uid).set({
        'userName': userName,
        'userId': user.uid,
        'lastSeen': DateTime.now(),
      });
    }

    try {
      Busy(true);
      var user = await _authService.signIn();
      await _firestore.collection('profile').doc(user.uid).set({
        'userName': userName,
        'userId': user.uid,
        'profileimage': '',
        'lastSeen': DateTime.now(),
      });
    } catch (e) {
      print(e);
    } finally {
      Busy(false);
    }
  }
}
