import 'package:communication/bloc/states/login_states/login_state.dart';
import 'package:built_collection/src/set.dart';


class LoginSuccess extends LoginState {

  final BuiltSet<String>? authorities;



  LoginSuccess({required this.authorities});



  @override

  List<Object> get props => [authorities ?? BuiltSet<String>()];

}
