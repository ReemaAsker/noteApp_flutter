import '../db/db_provider.dart';
import '../edit.dart';
import '../model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart'; // clock and date

class NoteScreen extends StatefulWidget {
  NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreen();
}

AddNote(NoteModel note) {
  DatabaseProvider.db.addNewNote(note);
  print("note added");
}

class _NoteScreen extends State<NoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String dateTime = DateFormat.jm().format(DateTime.now()) +
      ' ' +
      DateFormat(",dd MMMM ").format(DateTime.now());
  Color colorN = Color.fromARGB(255, 19, 33, 240);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('New Note'),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Icon(Icons.more_vert),
                    onTap: () {
                      final snackBar = SnackBar(
                        backgroundColor: colorN,
                        content: Container(
                          height: 220,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.share),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('Share with your friends'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.delete),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('Delete'),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.description_outlined),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('Duplicate'),
                                  SizedBox(height: 20),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.color_lens,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    child: Text("Change the color"),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Pick a color!'),
                                              content: BlockPicker(
                                                onColorChanged: (Color color) =>
                                                    setState(
                                                        () => colorN = color),
                                                pickerColor: colorN,
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  child: const Text('DONE'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); //dismiss the color picker
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                  GestureDetector(
                      child: Icon(Icons.done),
                      onTap: () {
                        NoteModel note = NoteModel(
                          titleController.text,
                          descController.text,
                          dateTime,
                          colorN.toString(),
                        );
                        AddNote(note);
                        print('yes');
                      }),
                  //   Navigator.pushReplacement(context,
                  //       MaterialPageRoute(builder: (context) => Edit()));
                  // }),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: colorN,
      ),
      body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  dateTime,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Type Somthing...',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 19, 33, 240),
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  controller: descController,
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Type Somthing...',
                    hintStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
