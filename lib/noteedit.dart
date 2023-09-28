import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notepad/note.dart';

class Noteedit extends StatefulWidget {
 String? title;
 String? content;
 String? id;
 Noteedit(this.title,this.content,this.id);

  @override
  State<Noteedit> createState() => _NoteeditState();
}

class _NoteeditState extends State<Noteedit> {
  update()async{
    var edit={
      "title":controller1.text,
      "content":controller2.text,
      "id":widget.id.toString()
    };
     Response response=await post(Uri.parse("http://192.168.1.34:8080/updateNotes"),body: jsonEncode(edit));
     if(response.statusCode==200){
       var updat1=jsonDecode(response.body);
       if(updat1["message"]=="note updated"){
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Note()));
       }
     }
  }
  TextEditingController controller1=TextEditingController();
  TextEditingController controller2=TextEditingController();
  @override
  void initState() {
    controller1.text=widget.title.toString();
    controller2.text=widget.content.toString();
    // TODO: implement initState
    super.initState();
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
              label: Text("title"),
              border: OutlineInputBorder()
            ),
          ),
          TextField(
            controller: controller2,
            decoration: InputDecoration(
              label: Text("Content"),
              border: OutlineInputBorder()
            ),
          ),
          ElevatedButton(onPressed: (){
            update();
          }, child: Text("Edit")),

        ],
      ),
    );
  }
}
