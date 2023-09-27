


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Test extends StatefulWidget {


  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List post = [];

  void getData() async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if(response.statusCode == 200){
      print(response.body);
      var json = jsonDecode(response.body);
    
      // setState(() {
      //     post = json;
      // });
    }
  }

  Widget build(BuildContext context){

    getData();
    return Scaffold(
      body: ListView.builder(
        itemCount: post.length,
        itemBuilder: (context, index) {
          return Text(post[index]["id"].toString());
        })
    );
  }
}