import 'package:communication/bloc/states/login_states/login_state.dart';

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}