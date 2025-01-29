import 'package:built_collection/src/set.dart';
import 'package:communication/bloc/blocs/login_bloc/login_bloc.dart';

import 'package:communication/bloc/events/login_events/login_button_event.dart';
import 'package:communication/bloc/states/login_states/login_failure_state.dart';
import 'package:communication/bloc/states/login_states/login_loading_state.dart';
import 'package:communication/bloc/states/login_states/login_state.dart';
import 'package:communication/bloc/states/login_states/login_success_state.dart';
import 'package:communication/widgets/home_page.dart';
import 'package:communication/widgets/media_content_upload.dart';
import 'package:flutter/material.dart';
import 'package:communication_openapi/openapi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 // final Openapi _openapi = Openapi();
  final Logger _logger = Logger('LoginForm');
  late final LoginBloc _loginBloc;


@override
void initState() {
  super.initState();
  _loginBloc = LoginBloc();
}


@override
void dispose() {
  _loginBloc.close();
  super.dispose();
}



@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[900],
    body: Center(
      child: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              _showErrorDialog('Login Failed', (state as LoginFailure).error);
            } else if (state is LoginSuccess) {
              if (state.authorities != null) {
                if (state.authorities!.contains("ROLE_ADMIN")) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MediaContentUploadPage()),
                  );
                } else if (state.authorities!.contains("ROLE_USER")) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              }
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SizedBox(
                width: 400,
                height: 400,
                child: Card(
                  color: Colors.grey[800],
                  margin: EdgeInsets.all(16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 16.0),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 16.0),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            _loginBloc.add(LoginButtonPressed(
                              username: _usernameController.text,
                              password: _passwordController.text,
                            ));
                          },
                          child: state is LoginLoading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                )
                              : Text('Login'),
                        ),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            _logger.info('Navigate to Forgot Password');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            _logger.info('Navigate to Sign Up');
                          },
                          child: Text(
                            'Don\'t have an account? Sign Up',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
  }

  // Function to display error dialogs
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
// Define the events




// Define the states





