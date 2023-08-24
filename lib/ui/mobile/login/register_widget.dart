import 'dart:ui';

import 'package:c_hat/dev/ext/widget_ext.dart';
import 'package:c_hat/ui/mobile/login/verify_widget.dart';
import 'package:c_hat/ui/shared/heading_text.dart';
import 'package:c_hat/ui/shared/register_bloc/register_bloc.dart';
import 'package:c_hat/ui/shared/register_bloc/register_event.dart';
import 'package:c_hat/ui/shared/register_bloc/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';

import '../splash_screen.dart';

class RegisterRoute extends StatefulWidget {
  final Platform platform;

  const RegisterRoute(this.platform, {Key? key}) : super(key: key);

  @override
  State<RegisterRoute> createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  final TextEditingController _usernameTextFieldController =
      TextEditingController();

  final TextEditingController _passwordTextFieldController =
      TextEditingController();

  final TextEditingController _mailIdTextFieldController =
      TextEditingController();

  final TextEditingController _serverIpTextFieldController =
      TextEditingController();

  var _ipError = false;
  var _mailError = false;
  var _passwordError = false;
  var _usernameError = false;

  final errorText = "This cannot be empty";

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(widget.platform,
        appBar: AppBar(
          title: const Text("Welcome!"),
        ),
        cupertinoBar: const CupertinoNavigationBar(
          middle: Text("Welcome!"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeadingText("Register"),
                  PlatformTextField(widget.platform,
                          hint: "Server IP",
                          controller: _serverIpTextFieldController,
                          errorText: _ipError ? errorText : null)
                      .withPadding(),
                  PlatformTextField(
                    widget.platform,
                    hint: "Username",
                    controller: _usernameTextFieldController,
                    errorText: _usernameError ? errorText : null,
                  ).withPadding(),
                  PlatformTextField(widget.platform,
                          hint: "Password",
                          controller: _passwordTextFieldController,
                          errorText: _passwordError ? errorText : null)
                      .withPadding(),
                  PlatformTextField(widget.platform,
                          hint: "Email",
                          controller: _mailIdTextFieldController,
                          errorText: _mailError ? errorText : null)
                      .withPadding(),
                  PlatformFilledButton(widget.platform,
                  minimumWidth: 256,
                          onPressed: onRegisterButtonPressed,
                          child: const Text("Register"))
                      .withPadding()
                ],
              ),
            ),
          ),
        ));
  }

  void onRegisterButtonPressed() {
    if (_serverIpTextFieldController.text.isEmpty ||
        _mailIdTextFieldController.text.isEmpty ||
        _passwordTextFieldController.text.isEmpty ||
        _usernameTextFieldController.text.isEmpty) {
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
      if (_usernameTextFieldController.text.isEmpty) {
        setState(() {
          _usernameError = true;
        });
      } else {
        _usernameError = false;
      }
      return;
    }

    final bloc = RegisterBloc()
      ..add(RegisterSentEvent(
          mailId: _mailIdTextFieldController.text,
          username: _usernameTextFieldController.text,
          password: _passwordTextFieldController.text,
          wsUrl: _serverIpTextFieldController.text));

    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<RegisterBloc, RegisterState>(
              bloc: bloc,
              builder: ((context, state) {
                if (state is RegisterWait) {
                  return SizedBox(
                      height: 50,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          content: SizedBox(
                            height: 100,
                            width: 100,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SplashScreen().withPadding(),
                                  const CircularProgressIndicator()
                                      .withPadding()
                                ]),
                          ),
                        ),
                      ));
                } else if (state is RegisterFailed) {
                  return SizedBox(
                    height: 100,
                    child: AlertDialog(
                      content: Center(
                        child: SizedBox(
                          height: 100,
                          child: Text(
                            state.message,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              listener: ((context, state) {
                if (state is RegisterVerify) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return VerifyWidget(widget.platform, bloc);
                  })));
                }
              }));
        });
  }
}