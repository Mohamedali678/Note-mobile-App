import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddnoteScreen extends StatelessWidget {
  void registerNote() async {
    var data =
        jsonEncode({"title": title.text, "description": description.text});

    try {
      var response = await http.post(
          Uri.parse("http://10.0.2.2:1000/api/create"),
          headers: {'Content-Type': 'application/json'},
          body: data);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  final title = TextEditingController();
  final description = TextEditingController();

  Widget build(BuildContext context) {
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
                registerNote();
                Navigator.pop(context);
              },
              height: 60,
              minWidth: double.infinity,
              color: Colors.orange,
              child: Text(
                "Save",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
