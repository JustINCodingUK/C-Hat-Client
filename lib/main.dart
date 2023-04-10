import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' show Platform;

import 'app/mobile_application.dart';
import 'app/desktop_application.dart';


void main(List<String> args) {
  runApp(const ChatApplication());
}

class ChatApplication extends StatelessWidget {
  const ChatApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if((Platform.isIOS || Platform.isAndroid)){
      return const MobileApplication();
    } else {
      return const MobileApplication();
    } 
  }
}