import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateNote extends StatelessWidget {
  var title = TextEditingController();
  var description = TextEditingController();

  var id;
  UpdateNote(this.id);

  void getData() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:1000/note/single/$id"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      title.text = json["title"];
      description.text = json["description"];
    } else {
      print("There is error");
    }
  }

  void updateData() async {
    // var data = jsonEncode();
    final response = await http.put(
        Uri.parse("http://10.0.2.2:1000/note/update/$id"),
        headers: {"Content-Type": "application/json"},
        body:
            jsonEncode({"title": title.text, "description": description.text}));
    if (response.statusCode == 200) {
      // showDialog(context: context, builder: (context){
      //   return AlertDialog(
      //     title: Text("Updated success"),
      //   );
      // });
      print("Updated success");
      print(response.body);
    } else {
      print("There is error");
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: title,
              decoration: InputDecoration(
                  hintText: "Enter title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: description,
              decoration: InputDecoration(
                  hintText: "Enter Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: MaterialButton(
              onPressed: () {
                updateData();
                Navigator.pop(context);
              },
              height: 60,
              minWidth: double.infinity,
              color: Colors.orange,
              child: Text(
                "Update",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
