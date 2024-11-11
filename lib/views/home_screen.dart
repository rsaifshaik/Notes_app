import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_copy/controller/firestore_database/firestore_db.dart';
import 'package:notes_app_copy/controller/local_db/local_db.dart';
import 'package:notes_app_copy/utils/constants.dart';
import 'package:notes_app_copy/views/add_note.dart';
import 'package:notes_app_copy/views/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> data=["Passwords","Aadhaar Cards"];
   FireStoreDB fireStoreDB= FireStoreDB();
  @override
  void initState() {
    getUserId();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes",style: TextStyle(color: Colors.white,fontSize: 24),),
        actions:  [
          TextButton(onPressed: (){
            signOut(context);
          }, child: Text("SignOut",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),)),
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(12)),
            child: IconButton(onPressed: () {},
                icon: const Icon(Icons.search,color: Colors.white,size: 20,)),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(12)),
            child: IconButton(onPressed: () {},
                icon: const Icon(Icons.notification_important,color: Colors.white,size: 20,)),
          )
        ],
      ),
      body: StreamBuilder(
           stream: FirebaseFirestore.instance.collection("notes").snapshots(),
          builder: (context,data){
             if(data.connectionState==ConnectionState.waiting) {
               return CircularProgressIndicator(color: Colors.black,);
             }
             if(!data.hasData){
               return Center(child: Text("Notes Not Found"),);
             }
             List<QueryDocumentSnapshot>  notes=data.data?.docs  ?? [];
             return ListView.builder(
               itemCount: notes.length,
               itemBuilder: (context, i) {
                 Map<String,dynamic> notesData=notes[i].data() as Map<String,dynamic>;
                 String id=notes[i].id;
                 String title=notesData["title"];
                 String content=notesData["content"];
                 return Card(
                   color: Colors.blue,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(title,style: TextStyle(color: Colors.white),),
                             IconButton(icon: Icon(Icons.delete,color: Colors.red,size: 20,),onPressed: (){
                               fireStoreDB.deleteNote(id);
                             },)
                           ],
                         )
                       ],
                     ),
                   ),
                 );
               }
             );
          }

      ),


      floatingActionButton: FloatingActionButton(
      backgroundColor: Constant.backgroundColor,
        onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNoteScreen()));
        }, child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }




  Future<void> signOut(BuildContext context)async{
        SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SignIn()));
   }

   void getUserId()async{
    String userId=await LocalDB.getUserId() ?? "";
    print(userId);
   }
}



class Duplicate extends StatefulWidget {
  const Duplicate({super.key});

  @override
  State<Duplicate> createState() => _DuplicateState();
}

class _DuplicateState extends State<Duplicate> {
  List<String> data=["Passwords","Aadhaar Cards"];

  @override
  void initState() {
    getUserId();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes",style: TextStyle(color: Colors.white,fontSize: 24),),
        actions:  [
          TextButton(onPressed: (){
            signOut(context);
          }, child: Text("SignOut",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),)),
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(12)),
            child: IconButton(onPressed: () {
            }, icon: const Icon(Icons.search,color: Colors.white,size: 20,)),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(12)),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.notification_important,color: Colors.white,size: 20,)),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (context,data){
          if(data.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator(color: Colors.black,);
          }
          if(!data.hasData){
            return Center(child: Text('Notes Not Found'),);
          }
          List<QueryDocumentSnapshot<Map<String,dynamic>>> notes=data.data?.docs ?? [];
          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context,i){
                Map<String,dynamic> notesData=notes[i].data();
                String title= notesData['title'];
                String content= notesData['content'];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),),
                            Text(content,style: TextStyle(color: Colors.white,fontSize: 16),)
                          ],
                        ),
                      )),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.backgroundColor,
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNoteScreen()));
        }, child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }




  Future<void> signOut(BuildContext context)async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SignIn()));
  }

  void getUserId()async{
    String userId=await LocalDB.getUserId() ?? "";
    print(userId);
  }
}


