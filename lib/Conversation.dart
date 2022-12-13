import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  final String userId;
  final String conversationId;
  const ConversationPage(
      {dynamic Key,
      dynamic key,
      required this.userId,
      required this.conversationId})
      : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late CollectionReference _ref;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _ref = FirebaseFirestore.instance
        .collection('conversations/${widget.conversationId}/messages');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1620922470003-8e2b2f2b2f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
            ),
            const SizedBox(
              width: 10,
            ),
            Text('User Name'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text('View Contact'),
                ),
                const PopupMenuItem(
                  child: Text('Media, links, and docs'),
                ),
                const PopupMenuItem(
                  child: Text('Search'),
                ),
                const PopupMenuItem(
                  child: Text('Mute notifications'),
                ),
                const PopupMenuItem(
                  child: Text('Wallpaper'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1620922470003-8e2b2f2b2f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _ref.orderBy('timeStamp').snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.hasData
                      ? ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return ListTile(
                              title: Align(
                                alignment: widget.userId == document['senderId']
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(document['message']),
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green[200],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        _ref.add({
                          'message': _controller.text,
                          'senderId': widget.userId,
                          'timeStamp': DateTime.now(),
                        });
                        _controller.text = '';
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.red,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
