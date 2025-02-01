import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habittracker_openapi/openapi.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    
    try {
      final Openapi openApi = Openapi();

      final loginVMBuilder = LoginVMBuilder()
        ..username = event.username
        ..password = event.password;

      final loginVM = loginVMBuilder.build();

      final loginResponse = await openApi.getAuthenticateControllerApi().authorize(loginVM: loginVM);

      if (loginResponse.statusCode == 200 || loginResponse.statusCode == 201) {
        Openapi.jwt = loginResponse.data!.idToken!;
        await openApi
            .getAccountResourceApi()
            .getAccount(headers: {'Authorization': 'Bearer ${Openapi.jwt}'});
        emit(LoginSuccess());
      } 
      else {
        emit(LoginFailure(error: 'Invalid credentials'));
      }
    }
    catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}




abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;

  const LoginSubmitted({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}




abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}