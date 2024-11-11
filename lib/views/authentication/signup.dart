import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_copy/controller/firebase_auth/firebase_auth_controller.dart';
import 'package:notes_app_copy/controller/local_db/local_db.dart';
import 'package:notes_app_copy/views/authentication/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuthController firebaseAuthController = FirebaseAuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text("Email", style: TextStyle(color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal),),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Enter Email",
                hintStyle: TextStyle(color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white)
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text("Enter Password", style: TextStyle(color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal)),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)
                      )
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: signUp,
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.white)
                        ),
                        child: Text("SignUp", style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      UserCredential? user = await firebaseAuthController.signUp(
          email.text, password.text);
      print(user?.user?.email);
      if (user != null) {
        String userId=user.user?.uid ?? '';
        LocalDB.setUserId(userId);
        LocalDB.setIsSignup(true);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something Went Wrong",style: TextStyle(color: Colors.redAccent,)),)
        );
      }
    }
    else if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Enter Email"), backgroundColor: Colors.redAccent,)
      );
    }
    else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Enter Password"),
            backgroundColor: Colors.redAccent,));
    }
  }
}
