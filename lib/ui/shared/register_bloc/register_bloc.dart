import 'package:c_hat/exceptions/webserver_exception.dart';
import 'package:c_hat/network/register_network_user/register_network_user.dart';
import 'package:c_hat/network/websocket_client/register_websocket_client.dart';
import 'package:c_hat/ui/shared/register_bloc/register_event.dart';
import 'package:c_hat/ui/shared/register_bloc/register_state.dart';
import 'package:c_hat/repository/register_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/network_status/status.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterState value;

  late RegisterRepository _repository;

  RegisterBloc({this.value = const RegisterWait()})
      : super(value) {
    on<RegisterSentEvent>((event, emit) async {
      _repository = RegisterRepository(
        RegisterWebsocketClient(wsUrl: event.wsUrl)
      );

      Status status;

      try {
        status = await _repository.register(RegisterNetworkUser(
          mailId: event.mailId, username: event.username, password: event.password
        ));
        if(status == Status.awaits) {
          emit(RegisterVerify());
        }
      } catch(exception) {
        if(exception is WebServerException) {
          status = Status.error;
          emit(RegisterFailed(exception.error));
        }
      }
    });

    on<OtpSendEvent>((event, emit) async {
      try {
        await _repository.verify(event.otp);
      } catch(exception) {
        if(exception is WebServerException) {
          emit(RegisterFailed(exception.error));
        }
      }
      emit(RegisterSuccess());
    });
  }
}
