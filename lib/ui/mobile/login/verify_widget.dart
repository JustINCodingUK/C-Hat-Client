import 'package:c_hat/ui/desktop/login_widget.dart';
import 'package:c_hat/ui/shared/register_bloc/register_bloc.dart';
import 'package:c_hat/ui/shared/register_bloc/register_event.dart';
import 'package:c_hat/ui/shared/register_bloc/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';

class VerifyWidget extends StatelessWidget {
  final Platform platform;
  final RegisterBloc bloc;
  final TextEditingController _verificationCodeController =
      TextEditingController();

  VerifyWidget(this.platform, this.bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(platform,
        appBar: AppBar(
          title: const Text("Verify your email"),
        ),
        cupertinoBar: const CupertinoNavigationBar(
          middle: Text("Verify your email"),
        ),
        body: BlocProvider.value(
          value: bloc,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformTextField(
                    platform,
                    hint: "Enter your verification code",
                    controller: _verificationCodeController,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlatformButton(
                        
                        platform,
                        minimumWidth: 10,
                        onPressed: () {},
                        child: const Text("Back"),
                      ),
                    ),
                    BlocListener<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text("Successfully registered",
                                      style: TextStyle(fontSize: 32)),
                                );
                              });
                        } else if (state is RegisterFailed) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Center(
                                    child: Text(state.message,
                                        style: const TextStyle(fontSize: 32)),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginRoute(platform))),
                                        child: const Text("Back"))
                                  ],
                                );
                              });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PlatformFilledButton(
                        
                          platform,
                          minimumWidth: 256,
                          onPressed: () {
                            bloc.add(OtpSendEvent(
                                int.parse(_verificationCodeController.text)));
                          },
                          child: const Text("Verify"),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
