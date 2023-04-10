import 'dart:async';
import 'dart:convert';

import 'package:c_hat/exceptions/webserver_exception.dart';
import 'package:c_hat/network/event/network_event.dart';
import 'package:c_hat/network/login_network_user/login_network_user.dart';
import 'package:c_hat/network/network_message/network_message.dart';
import 'package:c_hat/network/network_status/status.dart';
import 'package:c_hat/network/websocket_client/websocket_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatWebsocketClient extends WebsocketClient {
  
  @override
  late final WebSocketChannel channel;

  @override
  final String wsUrl;

  late final _broadcastStream = channel.stream.asBroadcastStream();

  ChatWebsocketClient({required this.wsUrl}) {
    channel = WebSocketChannel.connect(Uri.parse("wss://$wsUrl/chat"));
  }

  Future<LoginNetworkUser> login(LoginNetworkUser user) {

    final completer = Completer<LoginNetworkUser>();

    channel.sink.add(user.toJson());
    _broadcastStream.listen((event) {
          final jsonData = jsonDecode(event);
          if(mapToEvent(jsonData["event"]) == Event.auth) {
            if(mapToStatus(jsonData["status"]) == Status.error) {
              throw WebServerException(error: jsonData["message"]);
            } else {
              completer.complete(
                user
                  ..clientId = jsonData["client_id"]
                  ..username = jsonData["username"]
              );
            }
          }
         });

    return completer.future;
  }

  void sendMessage(NetworkMessage message) {
    channel.sink.add(message.toJson());    
  }

  void onMessageReceive(void Function(NetworkMessage message) onReceiveCallback) {
    _broadcastStream.listen((event) { 
        final jsonData = jsonDecode(event);
        if(mapToEvent(jsonData["event"]) == Event.message) {
          onReceiveCallback(NetworkMessage.fromJson(jsonData));
        }
    });
  }
}