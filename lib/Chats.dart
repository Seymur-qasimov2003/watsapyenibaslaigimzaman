import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watsapcloneee/models/conversation.dart';
import 'package:watsapcloneee/viewModels/chatsviewmodel.dart';

import 'Conversation.dart';
import 'core/locator.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final String userId = "hLKYNLBl7chas9xY8IbfsWaWh0U2";
  var model = getIt<ChatsModel>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: StreamBuilder<List<Conversation>>(
        stream: model.conversations(userId),
        builder: (context, AsyncSnapshot<List<Conversation>> snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading...'),
            );
          }
          return ListView(
            children: snapshot.data!.map((document) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(document.profileImage),
                ),
                trailing: Column(
                  children: [
                    Text('20:00'),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Center(
                          child: Text(
                        '30',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                title: Text(document.name),
                subtitle: Text(document.displayMessage),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConversationPage(
                                userId: userId,
                                conversationId: document.id,
                              )));
                },
              );
            }).toList(),
          );
        },
      ),
    );
    return Container();
  }
}
