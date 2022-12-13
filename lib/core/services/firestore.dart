import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watsapcloneee/models/conversation.dart';

class FirestoreDB {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore
        .collection('conversations')
        .where('users', arrayContains: userId)
        .snapshots();
    return ref.map((list) => list.docs
        .map((snapshots) => Conversation.FromSnapshot(snapshots))
        .toList());
  }
}
