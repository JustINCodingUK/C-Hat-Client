import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/model/user/user.dart';
import 'package:platform_ui/platform_ui.dart';

class UserView extends StatelessWidget {
  final User user;
  final Platform platform;

  const UserView(this.platform, {Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      platform,
      appBar: AppBar(
        title: Text(user.username),
      ),
      cupertinoBar: CupertinoNavigationBar(
        middle: Text(user.username),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 128),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.red,
                      foregroundImage: AssetImage("assets/images/user_avatar.png")),
                ),
                Text(user.username, style: const TextStyle(fontSize: 20))
              ],
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Client ID: ${user.clientId}"),
                  const Text("Last seen:")
                ],
              ),
            ),
          )
        ],
      ),

      actionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.flag, color: Colors.white),
        onPressed: () {
          
        },
      ),
    );
  }
}
