import 'dart:convert';

import 'package:annotations/annotations.dart';
import 'package:c_hat/model/user/user.dart';

part 'login_network_user.g.dart';

@dataClass
//ignore: unused_element
class _AbsLoginNetworkUser {
  late String mailId;
  late String password;
}

extension ToDomainModel on LoginNetworkUser {

  static Map fields = <String, Object>{
    "username": "",
    "clientId": "",
  };

  String? get username => fields["username"]; 
  set username(String? newUsername) {
    fields["username"] = newUsername;
  }

  String? get clientId => fields["clientId"];
  set clientId(String? newClientId) {
    fields["clientId"] = newClientId;
  }


  User toDomainModel(String username, String clientId) {
    return User(
      username: username,
      clientId: clientId
    );
  }

  String toJson() {
    return jsonEncode({
      "event": "auth",
      "mail_id": mailId,
      "password": password
    });
  }
}