import 'package:c_hat/network/network_status/status.dart';
import 'package:c_hat/network/register_network_user/register_network_user.dart';
import 'package:c_hat/network/websocket_client/register_websocket_client.dart';

class RegisterRepository {

  final RegisterWebsocketClient _wsClient;

  const RegisterRepository(this._wsClient);

  Future<Status> register(RegisterNetworkUser user) async {
    return await _wsClient.registerUser(user);
  }

  Future<Status> verify(int otp) async {
    return await _wsClient.completeVerification(otp);
  }

}