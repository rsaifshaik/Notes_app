import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_copy/controller/firestore_database/firestore_db.dart';
import 'package:notes_app_copy/controller/local_db/local_db.dart';
import 'package:notes_app_copy/views/widgets/custom_icon.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController title= TextEditingController();
  TextEditingController content=TextEditingController();
  FireStoreDB fireStoreDB=FireStoreDB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIcon(icon: CupertinoIcons.back,margin: EdgeInsets.only(left: 10),onPressed: (){Navigator.pop(context);},),
        actions: [
          CustomIcon(icon: Icons.save,onPressed: save,)
        ],
      ),
      body: Padding(
        padding:const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
             height: 20,
           ),
          Card(
            elevation: 10,
             color: Colors.grey,
             child: Padding(
               padding:EdgeInsets.symmetric(horizontal: 8),
             child: TextField(
               controller: title,
               decoration:InputDecoration(
                 hintText: "Title",
                 hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                 border: InputBorder.none
               ),
              ),
             ),
            ),
          SizedBox(
            height: 10,
          ),
          Card(
            elevation: 10,
            color: Colors.grey,
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: content,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: "Content",
                    hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
        ],
       ),
      ),
    );
  }
     void save()async{
       if (title.text.isNotEmpty && content.text.isNotEmpty){
         String userId=await LocalDB.getUserId() ?? "";
         String date=DateTime.now().toString();
         Map<String,dynamic> data={
           'title':title.text,
           'content':content.text,
           'user_id':userId,
           'create_at':date,
         };
         bool result= await fireStoreDB.addNote(data);
         if(result){
           showSuccessAlert("Note Added Successfully");
           Navigator.pop(context);
         }else{
           showAlert("Unable to add Note");
         }

       }else if(title.text.isEmpty){
         showAlert("Enter title");
       }else if(content.text.isEmpty) {
         showAlert("Enter content");
       }
     }


       void showAlert(String title){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
    backgroundColor: Colors.redAccent,
    content: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
    )
    );
     }


  void showSuccessAlert(String title){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
        )
    );
  }
}

