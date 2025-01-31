import 'package:flutter/material.dart';
import 'package:daily_journal_openapi/openapi.dart';
//import 'package:openapi/openapi.dart';
import 'daily_journal_widget.dart'; // Replace with your actual navigation target

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Openapi _openapi = Openapi();

  int? userId;
  String? userLogin;
  String? userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
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
                    onPressed: () async {
                      try {
                        LoginVMBuilder loginVMBuilder = LoginVMBuilder()
                          ..username = _usernameController.text
                          ..password = _passwordController.text;

                        LoginVM loginVM = loginVMBuilder.build();
                        final response = await _openapi
                            .getAuthenticateControllerApi()
                            .authorize(loginVM: loginVM);
                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          Openapi.jwt = response.data?.idToken!;
                          debugPrint(response.data?.idToken);
                          final responseUser = await _openapi
                              .getAccountResourceApi()
                              .getAccount(headers: {
                            'Authorization': 'Bearer ${Openapi.jwt}'
                          });
                          // userId = responseUser.data?.id;
                          userLogin = responseUser.data?.login;
                          userEmail = responseUser.data?.email;
                          print('succes');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DailyJournalWidget()),
                          );
                        } else {
                          print(
                              'Login failed with status code: ${response.statusCode}');
                          _showErrorDialog('Invalid username or password.');
                        }
                      } catch (e) {
                        print('Error during login: $e');
                        _showErrorDialog(
                            'An error occurred. Please try again.');
                      }
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
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
