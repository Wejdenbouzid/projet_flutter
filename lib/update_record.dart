import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class update_record extends StatefulWidget{

  String name;
  String email;
  String password;
  update_record(this.name,this.email,this.password);

  @override
  State<update_record> createState()=> _update_recordstate();
}
class _update_recordstate extends State <update_record>{
  
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> updaterecord() async
  {
    try{
      String uri = "http://localhost/practice_api/update_data.php";
      var res = await http.post(Uri.parse(uri),body: {
        "name":name.text,
        "email":email.text,
        "password":password.text
      });
      var response=jsonDecode(res.body);
      if(response["success"]=="true"){
          print("record updated");
        } else{
          print("some issue");
        }
    }
    catch(e){
      print(e);
      }
  }

  @override
  void initState(){
    // TODO: implement initstate
    name.text=widget.name;
    email.text=widget.email;
    password.text=widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("update record")),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child:TextFormField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter the name')
              ),
            ),
            ),
          Container(
            margin: EdgeInsets.all(10),
            child:TextFormField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter the email')
              ),
            ),
            ),
          Container(
            margin: EdgeInsets.all(10),
            child:TextFormField(
              controller: password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter the password')
              ),
            ),
            ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                updaterecord();
              },
              child: Text('update'),),
          ),
        ],
        ),
    );
  }
}