import 'package:communication/bloc/events/login_events/login_button_event.dart';
import 'package:communication/bloc/events/login_events/login_event.dart';
import 'package:communication/bloc/states/login_states/login_failure_state.dart';
import 'package:communication/bloc/states/login_states/login_initial_state.dart';
import 'package:communication/bloc/states/login_states/login_loading_state.dart';
import 'package:communication/bloc/states/login_states/login_state.dart';
import 'package:communication/bloc/states/login_states/login_success_state.dart';
import 'package:communication_openapi/openapi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:built_collection/built_collection.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Openapi _openapi = Openapi();
  final Logger _logger = Logger('LoginBloc');

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);

 
  }

  void _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
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
          _logger.info(Openapi.jwt);

          final userResponse = await _openapi
              .getAccountResourceApi()
              .getAccount(headers: {
            'Authorization': 'Bearer ${Openapi.jwt}'
          });      

          _logger.info(
              "account response status code: ${userResponse.statusCode}");

          if (userResponse.statusCode == 200) {
            BuiltSet<String>? authorities = userResponse.data?.authorities;
            emit(LoginSuccess(authorities: authorities));
          } else {
             emit(LoginFailure(error: 'Failed to fetch user account'));
          }
        } else {
           emit(LoginFailure(error: 'Invalid username or password'));
        }
      } catch (e) {
       emit(LoginFailure(error: e.toString()));
      }
    }
  }
