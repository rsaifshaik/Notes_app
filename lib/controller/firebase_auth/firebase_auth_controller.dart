import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthController{
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  Future<UserCredential?>  signUp(String email, String password)async{
   try{
    final result=await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return result;
   }catch(e){
     print(e);
     return null;
   }
  }

  Future<UserCredential?> signIn(String email,String password)async{
    try{
      final result= await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }
}