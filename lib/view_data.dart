import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/update_record.dart';
import 'package:http/http.dart' as http;

class view_data extends StatefulWidget{
  
  view_data({Key? key}) : super(key: key);

  @override
  State<view_data> createState()=> _view_datastate();
}
class _view_datastate extends State <view_data>{
  
  List userdata = [];

  Future<void> delrecord(String email) async {
    try{
      String uri = "http://localhost/practice_api/delete_data.php";
      
      var res = await http.post(Uri.parse(uri), body: {"email": email});
      var response = jsonDecode(res.body);
      if(response["success"] == "true"){
          print("record deleted");
          getrecord();
        } 
        else{
          print("some issue");
        }
    }
    catch(e){
      print(e);
      }
  }

  Future<void> getrecord() async{
    String uri = "http://localhost/practice_api/view_data.php";
    try{
      var response =await http.get(Uri.parse(uri));
      setState(() {
        userdata = jsonDecode(response.body);
      });
    }
    catch(e){
      print(e);
      }
  }

  @override
  void initState(){
    // TODO: implement initstate
    getrecord();
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("view data")),
      body: ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (context,index){
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: (){
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>update_record(
                    userdata[index]["uname"],
                    userdata[index]["uemail"],
                    userdata[index]["upassword"],
                    )));
              } ,
              leading: Icon(
                CupertinoIcons.heart,
                color: Colors.green,
              ),
              title: Text(userdata[index]["uname"]),
              subtitle: Text(userdata[index]["uemail"]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  delrecord(userdata[index]["uemail"]);
                },
                ),
            ),
          );
        },
      ),
    );
  }
}