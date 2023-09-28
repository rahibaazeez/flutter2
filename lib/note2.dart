import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/note.dart';
import 'package:http/http.dart';

class Note2 extends StatefulWidget {
   Note2({Key? key,}) : super(key: key);


  @override
  State<Note2> createState() => _Note2State();
}

class _Note2State extends State<Note2> {


  TextEditingController controller1=TextEditingController();
  TextEditingController controller2=TextEditingController();
  addnote()async{
    var body={
      "title":controller1.text,
      "content":controller2.text
    };
     Response response=await post(Uri.parse("http://192.168.1.34:8080/addNotes"),body: jsonEncode(body));
     if(response.statusCode==200){
       print(response.body);

       var bod1=jsonDecode(response.body);
       if(bod1["message"]=="inserted"){
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Note()));
       }
     }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: controller1,
            decoration: InputDecoration(
              label: Text("Title"),
              border: OutlineInputBorder(

              )
            ),

          ),
          TextField(
            controller: controller2,
            decoration: InputDecoration(
              label: Text("Note"),
              border: OutlineInputBorder()
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(onPressed: (){
              addnote();
             // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Note()));
            }, child: Text("Add notes")),
          )

        ],
      ),
    );
  }
}
