abstract class RegisterEvent {}

class RegisterSentEvent extends RegisterEvent {
  final String mailId;
  final String username;
  final String password;
  final String wsUrl;
  RegisterSentEvent({
    required this.mailId,
    required this.username,
    required this.password,
    required this.wsUrl
  });
}

class OtpSendEvent extends RegisterEvent {
  final int otp;
  OtpSendEvent(this.otp);
}
