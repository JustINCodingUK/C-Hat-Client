import 'package:c_hat/ui/shared/heading_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:universal_io/io.dart';

class LoginRoute extends StatelessWidget {
  LoginRoute(this.platform, {Key? key}) : super(key: key);

  final Platform platform;
  final _usernameTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      platform,
      appBar: AppBar(
        title: const Text("Welcome", style: TextStyle(fontSize: 16)),
      ),
      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Welcome", style: TextStyle(fontSize: 16)),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 128),
                const HeadingText("Login"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformTextField(platform,
                      controller: _usernameTextFieldController,
                      width: 256,
                      hint: "Username"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformTextField(platform,
                      controller: _passwordTextFieldController,
                      width: 256,
                      hint: "Password"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlatformButton(
                        platform,
                        minimumWidth: 19,
                        onPressed: () {
                          exit(0);
                        },
                        child: const Text("Exit"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlatformFilledButton(
                        
                        platform,
                        minimumWidth: 19,
                        onPressed: () {},
                        child: const Text("Login"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ClipRect(
            child: Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/background.jpg"),
              )
            ])),
          )
        ],
      ),
    );
  }
}
