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
      await platform.invokeMethod('showLogin');
      // Sau khi đăng nhập thành công, Native iOS sẽ điều hướng đến HomeViewController.
    } on PlatformException catch (e) {
      print("Failed to show login: ${e.message}");
    }
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    if (call.method == 'onDataListFetched') {
      setState(() {
        dataList = List<String>.from(call.arguments);
      });
      // Điều hướng đến màn hình Home với danh sách dữ liệu nhận được
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(dataList: dataList),
        ),
      );
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
  final List<String> dataList;

  HomeScreen({required this.dataList});

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
            ...dataList.map((item) => Text(item)).toList(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
  ));
}
