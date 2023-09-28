import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notepad/note2.dart';
import 'package:notepad/note3.dart';
import 'package:notepad/noteedit.dart';

class Note extends StatefulWidget {
   @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  getnote()async{
    Response response= await get(Uri.parse("http://192.168.1.34:8080/getNotes"));
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      return body;

    }
  }
removenot(String id)async{
    var remove1={
      "id":id
    };
    Response response=await post(Uri.parse("http://192.168.1.34:8080/removeNotes"),body: jsonEncode(remove1));
    print(response.body);
var remov2=jsonDecode(response.body);
    if(remov2["message"]=="deleted"){
      setState(() {

      });
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
          Center(child: Text("Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),)),
          Padding(
            padding: const EdgeInsets.only(left: 450),
            child: Row(
              children: [
                Icon(Icons.search),
                Icon(Icons.more_vert)
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getnote(),
              builder: (context,AsyncSnapshot snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data["message"].length,
                      itemBuilder: (context,index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap:(){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Noteedit(snapshot.data["message"][index]["title"],snapshot.data["message"][index]["content"],snapshot.data["message"][index]["id"].toString() )));
                            },
                            child: Container(

                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Align(alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: (){

                                            removenot(snapshot.data["message"][index]["id"].toString());
                                          },
                                            child: Icon(Icons.delete)),

                                      ),
                                      Text(snapshot.data["message"][index]["title"],style: TextStyle(fontWeight: FontWeight.bold
                                      ),),
                                      Text(snapshot.data["message"][index]["content"]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                }
               else{
                 return Center(child: Text("something went wrong"),);
                }
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: ElevatedButton(onPressed: (){

              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Note2()));
            }, child: Text("write notes")),

          )

        ],
      ),
    );
  }
}
