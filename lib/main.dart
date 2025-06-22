import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trackmytech/colors.dart';
import 'package:trackmytech/screens/home.dart';

void main() {
  runApp(const MyApp());
  dotenv.load().then((_) {
    print('Env loaded');
    // Optionally notify app that env is loaded via a state management solution
  }).catchError((e) {
    print('Failed to load .env: $e');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track My Tech',
      theme: ThemeData(
        primaryColor: AppColors.main,
        scaffoldBackgroundColor: AppColors.main,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

