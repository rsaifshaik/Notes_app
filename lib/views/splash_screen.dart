import 'package:flutter/material.dart';
import 'package:notes_app_copy/controller/local_db/local_db.dart';
import 'package:notes_app_copy/views/authentication/login.dart';
import 'package:notes_app_copy/views/home_screen.dart';

class Splashscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return  SplashScreenState();
  }
}
class SplashScreenState extends State<Splashscreen> {

  @override
  void initState() {
    navigate3second();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: Text("Notes",style: TextStyle(color: Colors.white,fontSize: 25),),
      )
    );
  }

  void navigate3second() {
    Future.delayed(const Duration(seconds: 3),()async{
     bool isLogin= await LocalDB.getIsLogin();
     bool isSignup=await LocalDB.getIsSignup();
     if(isLogin || isSignup){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
         return HomeScreen();
       }));
     }else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
         return SignIn();
       }));
     }
    });
  }
}
