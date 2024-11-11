
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreDB{
  FirebaseFirestore firestore=FirebaseFirestore.instance;

  Future<bool> addNote(Map<String,dynamic> data)async{
    try{
      final result= await firestore.collection('notes').add(data);
      return true;
    }catch(e){
      return false;
    }
  }



  Future<bool> deleteNote(String id )async{
    try{
      final result= await firestore.collection('notes').doc(id).delete();
      return true;
    }catch(e){
      return false;
    }
  }
}