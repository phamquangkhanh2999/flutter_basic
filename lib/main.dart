import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  static const platform = MethodChannel('login_plugin');

  void _startLoginProcess(BuildContext context) async {
    try {
      final List<dynamic> result = await platform.invokeMethod('showLogin');
      if (result is List<String>) {
        Navigator.pushNamed(context, '/home', arguments: result);
      } else {
        // Chuyển đổi kết quả thành List<String>
        final List<String> stringList =
            result.map((item) => item.toString()).toList();
        Navigator.pushNamed(context, '/home', arguments: stringList);
      }
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _startLoginProcess(context),
          child: Text('Start Login Process'),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> data =
        (ModalRoute.of(context)!.settings.arguments as List<dynamic>)
            .map((item) => item.toString())
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]),
          );
        },
      ),
    );
  }
}
