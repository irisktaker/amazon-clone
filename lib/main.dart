import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/constants/theme.dart';
import 'package:amazon_clone/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Demo',
      theme: AppTheme.lightTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthScreen(),
    );
  }
}
