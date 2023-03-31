import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/injection.dart';
import 'package:flutter_application_1/presentation/core/app_widget.dart';
import 'package:injectable/injectable.dart';
import 'firebase_options.dart';
void main() async{
   init(Environment.prod);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppWidget());
}


