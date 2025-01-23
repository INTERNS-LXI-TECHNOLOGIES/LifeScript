import 'package:habittracker_openapi/openapi.dart';
import 'package:dio/dio.dart';

class Authentication {
  final Openapi openApi = Openapi();

  Future<String?> authenticate(String username, String password) async {
    try {
      // Step 1: Build LoginVM
      final loginVMBuilder = LoginVMBuilder()
        ..username = username
        ..password = password;

      final login = loginVMBuilder.build();

      // Step 2: Authenticate and get the token
      final loginResponse = await openApi
          .getAuthenticateControllerApi()
          .authorize(loginVM: login);

      if (loginResponse.statusCode == 200 && loginResponse.data != null) {
        final bearerToken = loginResponse.data!.idToken;

        // Step 3: Validate the token
        final authResponse = await openApi
            .getAuthenticateControllerApi()
            .isAuthenticated(headers: {'Authorization': 'Bearer $bearerToken'});

        if (authResponse.statusCode == 200 || authResponse.statusCode == 201) {
          return bearerToken; // Return the token if authentication is successful
        } else {
          print('Authentication validation failed with status: ${authResponse.statusCode}');
          return null;
        }
      } else {
        print('Login failed with status: ${loginResponse.statusCode}');
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response data: ${e.response?.data}');
        print('Request path: ${e.requestOptions.path}');
      } else {
        print('Error: $e');
      }
      return null;
    }
  }
}
