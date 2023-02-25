import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

import 'MainScreen.dart';
import 'db/db_provider.dart';
import 'model/note_model.dart';

class Edit extends StatefulWidget {
  Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _Edit();
}

class _Edit extends State<Edit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final NoteModel note = ModalRoute.of(context)!.settings as NoteModel;
    String? title = note.title;
    String? desc = note.desc;
    String? dateTime = note.creationDate;
    String valueString =
        note.color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color colorN = Color(value);
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
                                                    DatabaseProvider.db
                                                        .deleteNote(note.id);
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
                        duration: Duration(seconds: 2),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                  GestureDetector(
                      child: Icon(Icons.done),
                      onTap: () {
                        DatabaseProvider.db.updateNote(NoteModel(
                            titleController.text,
                            descController.text,
                            DateTime.now().toString(),
                            colorN.toString()));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      }),
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
                  dateTime!,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: title,
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
                  decoration: InputDecoration(
                    hintText: desc,
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
