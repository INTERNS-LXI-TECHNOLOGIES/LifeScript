import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:openapiPomodoroBreak/openapi.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Openapi _openapi;

  LoginBloc(this._openapi) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      LoginVMBuilder loginVMBuilder = LoginVMBuilder()
        ..username = event.username
        ..password = event.password;
      LoginVM loginVM = loginVMBuilder.build();

      final response = await _openapi
          .getAuthenticateControllerApi()
          .authorize(loginVM: loginVM);

      if (response.statusCode == 200) {
        Openapi.jwt = response.data?.idToken;

        final accountResponse = await _openapi
            .getAccountResourceApi()
            .getAccount(headers: {'Authorization': 'Bearer ${Openapi.jwt}'});

        if (accountResponse.statusCode == 200) {
          emit(LoginSuccess(message: 'Authentication success'));
        } else {
          emit(LoginFailure(error: 'Failed to fetch account details.'));
        }
      } else {
        emit(LoginFailure(error: 'Invalid username or password.'));
      }
    } catch (e) {
      emit(LoginFailure(error: 'An error occurred: $e'));
    }
  }
}
