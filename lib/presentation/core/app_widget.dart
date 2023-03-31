

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/sign_in/sign_in.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DDD => Domain-Driven-Design Principlas',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green[800],
        accentColor:Colors.blueAccent,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ) 
      ),
      home:const SignInPage(),
    );
  }
}
