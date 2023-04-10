import 'package:c_hat/ui/mobile/login/register_widget.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_event.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/user_list/user_list_widget.dart';
import 'package:c_hat/ui/shared/heading_text.dart';

class LoginRoute extends StatelessWidget {
  LoginRoute(this.platform, {Key? key}) : super(key: key);

  final Platform platform;
  final _mailIdTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _serverIpTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      platform,
      appBar: AppBar(title: const Text("Welcome!")),
      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Welcome"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 128),
            const HeadingText("Login"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(platform,
                  controller: _serverIpTextFieldController,
                  width: 256,
                  hint: "Server IP",
                ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(
                platform,
                controller: _mailIdTextFieldController,
                width: 256,
                hint: "Mail ID",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(
                platform,
                controller: _passwordTextFieldController,
                width: 256,
                hint: "Password",
                isPassword: true,
              ),
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: PlatformFilledButton(
                        platform,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      RegisterRoute(platform))));
                        },
                        child: const Text("Register"),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlatformFilledButton(platform, onPressed: () {
      
                        final chatBloc = ChatWidgetBloc(value: MessageIdleState());

                        showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider<ChatWidgetBloc>(
                                create: (context) =>
                                    chatBloc
                                      ..add(InitiateConnectionEvent(
                                        mailId: _mailIdTextFieldController.text, 
                                        wsUrl: _serverIpTextFieldController.text, 
                                        password: _passwordTextFieldController.text
                                      )),
                                child: BlocConsumer<ChatWidgetBloc, ChatState>(
                                    listener: (blocContext, state) {
                                  if (state is LoginSuccess) {
                                    blocContext.read<ChatWidgetBloc>().add(LoginCompletedEvent(
                                      password: _passwordTextFieldController.text, 
                                      mailId: _mailIdTextFieldController.text, 
                                      wsUrl: _serverIpTextFieldController.text
                                    ));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserListRoute(
                                                    platform, chatBloc,
                                                    loggedInUser: state.user)));
                                  }
                                }, builder: (context, state) {
                                  if (state is LoginFailed) {
                                    return AlertDialog(
                                        content: SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          (state.message),
                                        ),
                                      ),
                                    ));
                                  } else {
                                    return const SizedBox(
                                      child: AlertDialog(
                                          content: SizedBox(
                                              height: 100,
                                              width: 10,
                                              child:
                                                  CircularProgressIndicator())),
                                    );
                                  }
                                }),
                              );
                            });
                      }, child: const Text("Login")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: PlatformButton(platform, onPressed: () {
                        SystemNavigator.pop();
                      }, child: const Text("Exit")),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
