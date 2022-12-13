import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String id;
  String name;
  String displayMessage;
  String profileImage;

  Conversation({
    required this.id,
    required this.name,
    required this.displayMessage,
    required this.profileImage,
  });
  factory Conversation.FromSnapshot(DocumentSnapshot snapshot) {
    return Conversation(
      id: snapshot.id,
      name: snapshot['name'],
      displayMessage: snapshot['displayMessage'],
      profileImage: snapshot['profileImage'],
    );
  }
}
