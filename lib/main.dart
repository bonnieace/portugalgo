import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import the Get package
import 'package:portugalgo/auth/forget_password.dart';
import 'package:portugalgo/auth/login.dart';
import 'package:portugalgo/auth/signup.dart';

import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Replace MaterialApp with GetMaterialApp
      title: 'Portugal Go',
         themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: LoginScreen(),
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/forget_password', page: () => ForgetPassword()),
      ],
    );
  }
}
