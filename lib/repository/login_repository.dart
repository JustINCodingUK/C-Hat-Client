import 'package:c_hat/model/user/user.dart';
import 'package:c_hat/network/login_network_user/login_network_user.dart';
import 'package:c_hat/network/websocket_client/chat_websocket_client.dart';

class LoginRepository {

  final ChatWebsocketClient _wsClient;

  const LoginRepository(this._wsClient);

  Future<User> login(LoginNetworkUser loginUser) async {
    var user = await _wsClient.login(loginUser);
    return user.toDomainModel(user.username!, user.clientId!);
  }
  
}