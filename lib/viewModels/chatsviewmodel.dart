import 'package:flutter/cupertino.dart';
import 'package:watsapcloneee/viewModels/base_model.dart';

import '../core/locator.dart';
import '../core/services/firestore.dart';
import '../models/conversation.dart';

class ChatsModel extends BaseModel {
  Stream<List<Conversation>> conversations(String userId) {
    return getIt<FirestoreDB>().getConversations(userId);
  }
}

///deyisikleri yadda saxlayaraq ui tarafina gonderiyor
