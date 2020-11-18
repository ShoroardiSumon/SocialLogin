import 'package:flutter/material.dart';
import 'package:socialLogin/auth_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Social Login',
      theme: ThemeData(
        
        primarySwatch: Colors.indigo,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthPage(),
    );
  }
}
