import 'package:web_socket_channel/web_socket_channel.dart';

abstract class WebsocketClient {
  abstract final String wsUrl;
  abstract final WebSocketChannel channel;

  void disconnect() {
    channel.sink.close();
  }
}