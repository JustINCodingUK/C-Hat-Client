import 'dart:convert';

import 'package:annotations/annotations.dart';

part 'register_network_user.g.dart';

@dataClass
// ignore: unused_element
class _AbsRegisterNetworkUser {
  late String mailId;
  late String username;
  late String password;
}

extension RegisterNetworkUserUtils on RegisterNetworkUser {
  String toJson() {
    return jsonEncode({
      "event": "register",
      "mail_id": mailId,
      "username": username,
      "password": password
    });
  }
}