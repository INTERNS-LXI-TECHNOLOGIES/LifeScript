import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:openapiperfectday/openapi.dart';
import 'package:perfectday_frontend/PerfectdayWidget.dart';
import 'package:perfectday_frontend/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Singleton instance of OpenAPI
  final Openapi openapi = Openapi();

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Create a LoginVMBuilder and build the login object
      LoginVMBuilder loginBuilder = LoginVMBuilder()
        ..username = _usernameController.text
        ..password = _passwordController.text;

      LoginVM loginVM = loginBuilder.build();

      // Call the API
      final response = await openapi
          .getAuthenticateControllerApi()
          .authorize(loginVM: loginVM);

      print('response:$response');
      if (response.statusCode == 200) {
        // Assume JWT is returned in the response data
        final jwt = response.data?.idToken;
        debugPrint('JWT Token: $jwt');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
        print('response:$response');
        // Navigate to the home page
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const Perfectdayplan1Widget()), // Assuming HomePage() is your next page
        );
      } else {
        // Show error message for invalid credentials
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')),
        );
      }
    } catch (e) {
      // Handle API errors
      debugPrint('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
