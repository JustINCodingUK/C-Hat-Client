import 'dart:ui';

import 'package:c_hat/dev/ext/widget_ext.dart';
import 'package:c_hat/ui/mobile/login/register_widget.dart';
import 'package:c_hat/ui/mobile/splash_screen.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_event.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/user_list/user_list_widget.dart';
import 'package:c_hat/ui/shared/heading_text.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute(this.platform, {Key? key}) : super(key: key);

  final Platform platform;

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final _mailIdTextFieldController = TextEditingController();

  final _passwordTextFieldController = TextEditingController();

  final _serverIpTextFieldController = TextEditingController();

  var _mailError = false;

  var _ipError = false;

  var _passwordError = false;

  final errorText = "This cannot be empty";

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      widget.platform,
      appBar: AppBar(title: const Text("Welcome!")),
      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Welcome"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 256,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeadingText("Login"),
                PlatformTextField(widget.platform,
                        controller: _serverIpTextFieldController,
                        width: 256,
                        hint: "Server URL",
                        errorText: _ipError ? errorText : null)
                    .withPadding(),
                PlatformTextField(widget.platform,
                        controller: _mailIdTextFieldController,
                        width: 256,
                        hint: "Mail ID",
                        errorText: _mailError ? errorText : null)
                    .withPadding(),
                PlatformTextField(widget.platform,
                        controller: _passwordTextFieldController,
                        width: 256,
                        hint: "Password",
                        isPassword: true,
                        errorText: _passwordError ? errorText : null)
                    .withPadding(),
                const SizedBox(height: 16),
                PlatformFilledButton(widget.platform,
                minimumWidth: 256,
                        onPressed: onLoginButtonPressed,
                        child: const Text("Login"))
                    .withPadding(),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(),
                    ),
                    const Text("OR").withPadding(),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                PlatformFilledButton(
                  widget.platform,
                  minimumWidth: 256,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              RegisterRoute(widget.platform)))),
                  child: const Text("Register"),
                ).withPadding(padding: 32)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLoginButtonPressed() {
    if (_serverIpTextFieldController.text.isEmpty ||
        _mailIdTextFieldController.text.isEmpty ||
        _passwordTextFieldController.text.isEmpty) {
      if (_passwordTextFieldController.text.isEmpty) {
        setState(() {
          _passwordError = true;
        });
      } else {
        setState(() {
          _passwordError = false;
        });
      }

      if (_mailIdTextFieldController.text.isEmpty) {
        setState(() {
          _mailError = true;
        });
      } else {
        setState(() {
          _mailError = false;
        });
      }
      if (_serverIpTextFieldController.text.isEmpty) {
        setState(() {
          _ipError = true;
        });
      } else {
        setState(() {
          _ipError = false;
        });
      }
      return;
    }

    context.read<ChatBloc>().add(InitiateConnectionEvent(
        mailId: _mailIdTextFieldController.text,
        wsUrl: _serverIpTextFieldController.text,
        password: _passwordTextFieldController.text));
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<ChatBloc, ChatState>(
              listener: (blocContext, state) {
            if (state is LoginSuccess) {
              blocContext.read<ChatBloc>().add(LoginCompletedEvent(
                  password: _passwordTextFieldController.text,
                  mailId: _mailIdTextFieldController.text,
                  wsUrl: _serverIpTextFieldController.text));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserListRoute(widget.platform,
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
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: AlertDialog(
                  content: SizedBox(
                    height: 100,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const SplashScreen().withPadding(),
                      const CircularProgressIndicator().withPadding()
                    ]),
                  ),
                ),
              );
            }
          });
        });
  }
}
