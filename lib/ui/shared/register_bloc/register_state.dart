abstract class RegisterState {
  const RegisterState();
}

class RegisterWait extends RegisterState {
  const RegisterWait();
}

class RegisterSuccess extends RegisterState {}

class RegisterVerify extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String message;
  RegisterFailed(this.message);
}
