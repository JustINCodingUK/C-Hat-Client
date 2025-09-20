import 'dart:async';
import 'dart:convert';

import 'package:c_hat/exceptions/webserver_exception.dart';
import 'package:c_hat/network/event/network_event.dart';
import 'package:c_hat/network/register_network_user/register_network_user.dart';
import 'package:c_hat/network/websocket_client/websocket_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../network_status/status.dart';

class RegisterWebsocketClient extends WebsocketClient {
  @override
  late WebSocketChannel channel;

  @override
  final String wsUrl;

  late final _broadcastStream = channel.stream.asBroadcastStream();

  RegisterWebsocketClient({required this.wsUrl}) {
    channel = WebSocketChannel.connect(Uri.parse("$wsUrl/register"));
  }

  Future<Status> registerUser(RegisterNetworkUser user) {
    final completer = Completer<Status>();

      channel.sink.add(user.toJson());
      _broadcastStream.listen((event) { 
          final jsonData = jsonDecode(event);
          if(mapToEvent(jsonData["event"]) == Event.register) {
            if(mapToStatus(jsonData["status"]) == Status.error) {
              throw WebServerException(error: jsonData["message"]);
            } else {
              completer.complete(Status.awaits);
            }
          }
        });

    return completer.future;
  }

  Future<Status> completeVerification(int otp) async {
    final completer = Completer<Status>();

      channel
        .sink.add(jsonEncode({
          "event": "confirmation",
          "code": otp
        }));
        _broadcastStream.listen((event) { 
          final jsonData = jsonDecode(event);
          if(mapToEvent(jsonData["event"]) == Event.confirmation) {
            if(mapToStatus(jsonData["status"]) == Status.error) {
              throw WebServerException(error: jsonData["message"]);
            } else {
              completer.complete(Status.done);
            }
          }
        });

    return completer.future;
  }
  
}