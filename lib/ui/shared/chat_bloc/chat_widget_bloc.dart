import 'package:c_hat/database/chat_database.dart';
import 'package:c_hat/exceptions/webserver_exception.dart';
import 'package:c_hat/model/user/user.dart';
import 'package:c_hat/network/login_network_user/login_network_user.dart';
import 'package:c_hat/network/websocket_client/chat_websocket_client.dart';
import 'package:c_hat/repository/login_repository.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_event.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_state.dart';
import 'package:c_hat/repository/message_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatWidgetBloc extends Bloc<ChatEvent, ChatState> {
  ChatState value;
  late User loggedInUser;

  late MessageRepository _messageRepository;
  late LoginRepository _loginRepository;
  late ChatWebsocketClient _wsClient;

  ChatWidgetBloc({required this.value}) : super(value) {
    on<InitiateConnectionEvent>((event, emit) async {
      _wsClient = ChatWebsocketClient(wsUrl: event.wsUrl);
      _loginRepository = LoginRepository(_wsClient);
      try {
        loggedInUser = await _loginRepository.login(
          LoginNetworkUser(
            mailId: event.mailId,
            password: event.password
          )
        );
        emit(LoginSuccess(loggedInUser));
      } catch(exception) {
        if(exception is WebServerException) {
          emit(LoginFailed(exception.error));
        } else {
          rethrow;
        }
      }

      _messageRepository = MessageRepository(
        await getDatabase(),
        _wsClient
      );

      _messageRepository.onMessageReceived((message) { 
        add(MessageReceivedEvent(message));
      });

    });

    on<LoginCompletedEvent>((event, emit) async {
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setString("loggedInUser.password", event.password);
      await sharedPrefs.setString("loggedInUser.mailId", event.mailId);
      await sharedPrefs.setString("serverIP", event.wsUrl);
      await sharedPrefs.setBool("isLoggedIn", true);
    });

    on<MessageReceivedEvent>((event, emit) {
      emit(MessageReceivedState(event.message));
    });

    on<MessageSentEvent>((event, emit) {
      _messageRepository.sendMessage(event.message);
      emit(LatestMessageReceived(event.message));
    });

    on<MessagesRequestedEvent>((event, emit) async {
      final messages = await _messageRepository.getMessagesByUserClientId(event.clientId);
      emit(MessagesReceivedFromDatabase(messages));
    });

  }
}