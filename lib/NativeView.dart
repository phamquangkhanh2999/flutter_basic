import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const platform = MethodChannel('login_plugin');
  List<String> dataList = [];

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(_handleMethod);
  }

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
            builder: (context) => HomeScreen(
                username: username, password: password, dataList: dataList),
          ),
        );
      }
    } on PlatformException catch (e) {
      print("Failed to show login: ${e.message}");
    }
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    if (call.method == 'onDataListFetched') {
      setState(() {
        dataList = List<String>.from(call.arguments);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
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
  final List<String> dataList;

  HomeScreen(
      {required this.username, required this.password, required this.dataList});

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
            ...dataList.map((item) => Text(item)).toList(),
          ],
        ),
      ),
    );
  }
}
