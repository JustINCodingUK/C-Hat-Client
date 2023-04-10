import 'package:c_hat/ui/mobile/login/verify_widget.dart';
import 'package:c_hat/ui/shared/heading_text.dart';
import 'package:c_hat/ui/shared/register_bloc/register_bloc.dart';
import 'package:c_hat/ui/shared/register_bloc/register_event.dart';
import 'package:c_hat/ui/shared/register_bloc/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';

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

  final TextEditingController _mailTextFieldController =
      TextEditingController();

  final TextEditingController _serverIpTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(widget.platform,
        appBar: AppBar(
          title: const Text("Welcome!"),
        ),
        cupertinoBar: const CupertinoNavigationBar(
          middle: Text("Welcome!"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 128),
              const HeadingText("Register"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlatformTextField(widget.platform,
                    hint: "Server IP",
                    controller: _serverIpTextFieldController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlatformTextField(widget.platform,
                    hint: "Username", controller: _usernameTextFieldController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlatformTextField(widget.platform,
                    hint: "Password", controller: _passwordTextFieldController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlatformTextField(widget.platform,
                    hint: "Email", controller: _mailTextFieldController),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PlatformFilledButton(widget.platform, onPressed: () {

                      final bloc = RegisterBloc()
                        ..add(RegisterSentEvent(
                          mailId: _mailTextFieldController.text,
                          username: _usernameTextFieldController.text,
                          password: _passwordTextFieldController.text,
                          wsUrl: _serverIpTextFieldController.text
                        ));

                      showDialog(
                          context: context,
                          builder: (context) {
                            return BlocConsumer<RegisterBloc, RegisterState>(
                                bloc: bloc,
                                builder: ((context, state) {
                                  if (state is RegisterWait) {
                                    return const SizedBox(
                                      height: 50,
                                      child: AlertDialog(
                                        content: Center(
                                          child: SizedBox(
                                            height: 100,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (state is RegisterFailed) {
                                    return SizedBox(
                                      height: 100,
                                      child: AlertDialog(
                                        content: Center(
                                          child: SizedBox(
                                            height: 100,
                                            child: Text(
                                              state.message,
                                              style:
                                                  const TextStyle(fontSize: 32),
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
                                      return VerifyWidget(
                                          widget.platform, bloc);
                                    })));
                                  }
                                }));
                          });
                    }, child: const Text("Register")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: PlatformButton(widget.platform, onPressed: () {
                      //SystemNavigator.pop();
                    }, child: const Text("Back")),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
