import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watsapcloneee/Calls.dart';
import 'package:watsapcloneee/Camera.dart';
import 'package:watsapcloneee/Chats.dart';
import 'package:watsapcloneee/Status.dart';

class WhatsapMainPage extends StatefulWidget {
  const WhatsapMainPage({Key? key}) : super(key: key);

  @override
  State<WhatsapMainPage> createState() => _WhatsapMainPageState();
}

class _WhatsapMainPageState extends State<WhatsapMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showMessageButton = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          _showMessageButton = false;
        });
      } else {
        setState(() {
          _showMessageButton = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: TabBarView(
          controller: _tabController,
          children: [
            CameraPage(),
            ChatsPage(),
            StatusPage(),
            CallsPage(),
          ],
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
              title: Text('Whatsap clone'),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.camera_alt),
                  ),
                  Tab(
                    text: 'CHATS',
                  ),
                  Tab(
                    text: 'STATUS',
                  ),
                  Tab(
                    text: 'CALLS',
                  ),
                ],
              ),
            )
          ];
        },
      ),
      floatingActionButton: _showMessageButton
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.message),
            )
          : null,
    );
  }
}
