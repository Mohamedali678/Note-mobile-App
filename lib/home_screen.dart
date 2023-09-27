import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/add_note.dart';
import 'package:flutter_application_1/update_note.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List notes = [];

  void getAllNotes() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:1000/notes"));
    if (response.statusCode == 200) {
      setState(() {
        notes = jsonDecode(response.body);
      });
    } else {
      print("There is error");
    }
  }

  void deleteNote(id) async {
    final response =
        await http.delete(Uri.parse("http://10.0.2.2:1000/note/delete/$id"));

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Note deleted successfully"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            );
          });
    } else {
      print("There is error");
    }
  }

  void getSingleNote(id) async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:1000/note/single/$id"));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("there is error");
    }
  }

  Widget build(BuildContext context) {
    getAllNotes();
    return Scaffold(
      appBar: AppBar(title: Text("Nooty"), backgroundColor: Colors.orange),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return InkWell(
              onLongPress: () {
                deleteNote(notes[index]["_id"]);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 90,
                width: 200,
                color: Color.fromARGB(255, 184, 211, 208),
                child: Column(
                  children: [
                    Text(notes[index]["title"]),
                    Text(notes[index]["description"]),
                    SizedBox(
                      height: 60,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UpdateNote(notes[index]["_id"]);
                              }));
                            },
                            icon: Icon(Icons.edit)))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 50,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddnoteScreen();
            }));
          }),
    );
  }
}
