import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/view_data.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> insertrecord() async
  {
    if(name.text !="" || email.text !="" || password.text !=""){
      try{
        String uri = "http://localhost/practice_api/insert_record.php";
        var res =await http.post(Uri.parse(uri),body: {
          "name":name.text,
          "email":email.text,
          "password":password.text
        });

        var response=jsonDecode(res.body);
        if(response["success"]=="true"){
          print("record inserted");
        } else{
          print("some issue");
        }
      }
      catch(e){
        print(e);
      }
    }else{
      print("please fill all fileds");
    }
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(appBar: AppBar(
        title: Text('Insert Record'),
        ),
        body: Column(children: [
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
                insertrecord();
              },
              child: Text('insert'),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Builder(
              builder: (context){
                return ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>view_data()));
                  }, 
                  child: Text("View Data"));
              },
              ),
          )
            ]),
        ),
    );
  }
}