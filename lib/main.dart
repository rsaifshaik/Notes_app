 import 'package:flutter/material.dart';
import 'package:notes_app_copy/utils/constants.dart';
import 'package:notes_app_copy/views/authentication/login.dart';
import 'package:notes_app_copy/views/authentication/signup.dart';
import 'package:notes_app_copy/views/home_screen.dart';
import 'package:notes_app_copy/views/splash_screen.dart';
 import 'package:firebase_core/firebase_core.dart';
 import 'firebase_options.dart';

 // ...

    void main()async{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
    }

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Constant.backgroundColor),
        scaffoldBackgroundColor: Constant.backgroundColor
      ),
      home: Splashscreen(),
    );
  }
}
