import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_copy/controller/firebase_auth/firebase_auth_controller.dart';
import 'package:notes_app_copy/controller/local_db/local_db.dart';
import 'package:notes_app_copy/views/authentication/signup.dart';
import 'package:notes_app_copy/views/home_screen.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuthController firebaseAuthController = FirebaseAuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text("Login",style: TextStyle(color: Colors.white,fontSize: 24),),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text("Email", style: TextStyle(color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal),),
          TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Enter Email",
              hintStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text("Password", style: TextStyle(color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: signIn,
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.white),
                      ),
                      child: const Text(
                        "SignIn", style: TextStyle(color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 16),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                  }, child: const Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),))
                ],
              )
            ],
          )
    ]
      )
    );
  }

  void signIn() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      UserCredential? user = await firebaseAuthController.signIn(email.text, password.text);
      if(user!=null){
        String userId=user.user?.uid ??"";
        LocalDB.setIsLogin(true);
        LocalDB.setUserId(userId);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
     else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
              "Something Went Wrong", style: TextStyle(color: Colors.redAccent),))
        );
      }
    }
    else if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
            "Invalid Email", style: TextStyle(color: Colors.redAccent),))
      );
    }
    else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
            "Invalid Password", style: TextStyle(color: Colors.redAccent),))
      );
    }
  }
}
