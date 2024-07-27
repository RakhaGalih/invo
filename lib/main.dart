import 'package:flutter/material.dart';
import 'package:invo/model/provider/data_model.dart';
import 'package:invo/page/auth/forgot_password_page.dart';
import 'package:invo/page/auth/signup_page.dart';
import 'package:invo/page/auth/stepper_page.dart';
import 'package:invo/page/home/edit_profile_page.dart';
import 'package:invo/page/home/home.dart';
import 'package:invo/page/home/profile_page.dart';
import 'package:provider/provider.dart';

import 'page/auth/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataModel>(
      create: (_) => DataModel(),
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: "Poppins",
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue),
        initialRoute: '/stepper',
        routes: {
          '/stepper': (context) => const StepperPage(),
          '/login': (context) => const LoginPage(),
          '/signUp': (context) => const SignupPage(),
          '/home': (context) => const Home(),
          '/forgotPassword': (context) => const ForgotPasswordPage(),
          '/edit': (context) => const EditProfile(),
        },
      ),
    );
  }
}
