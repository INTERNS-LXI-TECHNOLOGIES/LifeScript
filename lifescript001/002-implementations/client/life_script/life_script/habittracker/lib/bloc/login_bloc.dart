import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habittracker_openapi/openapi.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final Openapi openApi = Openapi();

      final loginVMBuilder = LoginVMBuilder()
        ..username = event.username
        ..password = event.password;

      final loginVM = loginVMBuilder.build();

      final loginResponse =
          await openApi.getAuthenticateControllerApi().authorize(loginVM: loginVM);

      if (loginResponse.statusCode == 200 || loginResponse.statusCode == 201) {
        Openapi.jwt = loginResponse.data!.idToken!;
        final responseUser = await openApi
            .getAccountResourceApi()
            .getAccount(headers: {'Authorization': 'Bearer ${Openapi.jwt}'});
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: 'Invalid credentials'));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
