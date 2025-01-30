import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:openapiperfectday/openapi.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Openapi openapi= Openapi();

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        LoginVMBuilder loginBuilder = LoginVMBuilder()
          ..username = event.username
          ..password = event.password;

        LoginVM loginVM = loginBuilder.build();

        final response = await openapi
            .getAuthenticateControllerApi()
            .authorize(loginVM: loginVM);

        if (response.statusCode == 200) {
          Openapi.jwt = response.data!.idToken!;
          emit(LoginSuccess(jwtToken:Openapi.jwt ?? ''));
        } else {
          emit(LoginFailure(error: 'Invalid username or password'));
        }
      } catch (e) {
        emit(LoginFailure(error: 'An error occurred: $e'));
      }
    });
  }
}

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
   List<String>? authorities;

}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String jwtToken;
   

  LoginSuccess({required this.jwtToken});

  @override
  List<Object> get props => [jwtToken];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
