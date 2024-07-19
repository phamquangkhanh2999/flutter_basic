import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  static const platform = MethodChannel('login_plugin');

  Future<void> _showNativeLogin(BuildContext context) async {
    try {
      final Map<dynamic, dynamic> result =
          await platform.invokeMethod('showLogin');
      final username = result['username'] as String?;
      final password = result['password'] as String?;

      if (username != null && password != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomeScreen(username: username, password: password),
          ),
        );
      }
    } on PlatformException catch (e) {
      print("Failed to show login: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showNativeLogin(context),
          child: Text('Login with Native UI'),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String username;
  final String password;

  HomeScreen({required this.username, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Username: $username'),
            Text('Password: $password'),
          ],
        ),
      ),
    );
  }
}
