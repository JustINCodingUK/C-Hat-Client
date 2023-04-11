import 'package:c_hat/ui/shared/chat_bloc/chat_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_io/io.dart' show Platform;

import 'app/mobile_application.dart';
import 'app/desktop_application.dart';


void main(List<String> args) {
  runApp(
    BlocProvider<ChatBloc>(
      create: (_) => ChatBloc(value: MessageIdleState()),
      child: const ChatApplication()
    )
  );
}

class ChatApplication extends StatelessWidget {
  const ChatApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if((Platform.isIOS || Platform.isAndroid)){
      return const MobileApplication();
    } else {
      return const DesktopApplication();
    } 
  }
}