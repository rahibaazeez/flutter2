import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/postapiexampl2.dart';
import 'package:http/http.dart';

class Postapi4 extends StatefulWidget {
  const Postapi4({Key? key}) : super(key: key);

  @override
  State<Postapi4> createState() => _Postapi4State();
}

class _Postapi4State extends State<Postapi4> {
  TextEditingController controller1=TextEditingController();
  TextEditingController controller2=TextEditingController();
  postdata()async{
    var body={
      "email":controller1.text,
      "password":controller2.text
    };

       Response response=await post(Uri.parse("http://192.168.29.180:8080/logindata"),body: jsonEncode(body));
    if(response.statusCode==200){
      print(response.body);


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
              label: Text("Email"),
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: controller2,

            decoration: InputDecoration(
              label: Text("Password"),
              border: OutlineInputBorder()
            ),
          ),
          ElevatedButton(onPressed: (){
            postdata();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Postapi5()));
          }, child: Text("submit"))
        ],
      ),
    );
  }
}
