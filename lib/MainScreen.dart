import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:noteapp/db/db_provider.dart';

import 'model/note_model.dart';
import 'screens/add_note.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  late List<NoteModel> list;
  Future<List<NoteModel>?> getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    list = notes!;
    return notes;
  }

  Color color = Color.fromARGB(255, 19, 33, 240);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY Notes'),
        centerTitle: true,
        backgroundColor: color,
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, noteData) {
          if (noteData.data == null) {
            return Container(
              padding: const EdgeInsets.only(top: 150),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/noteicon.png'),
                    SizedBox(height: 40),
                    Text(
                      'No Notes :(',
                      style: TextStyle(
                        color: Color.fromARGB(255, 98, 92, 152),
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'You have no task to do.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 174, 213, 213),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } //end if
          else {
            return Container(
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: list.length,
                  //noteData.data.length,
                  itemBuilder: (context, index) {
                    String title = list.elementAt(index).title;
                    String desc = list.elementAt(index).title;
                    String creationDate = list.elementAt(index).title;
                    String color = list.elementAt(index).title;

                    //noteData.data.;
                    //String desc = noteData.data[index]['desc'];
                    // String creationDate = noteData.data[index]['creationDate'];
                    // String color = noteData.data[index]['color'];
                    // int id = noteData.data[index]['id'];

                    String valueString =
                        color.split('(0x')[1].split(')')[0]; // kind of hacky..
                    int value = int.parse(valueString, radix: 16);
                    Color colorC = Color(value);
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(color: colorC, width: 5))),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, "showNote",
                                arguments: NoteModel(
                                  title,
                                  desc,
                                  creationDate,
                                  color,
                                ));
                          },
                          title: Text(title),
                          subtitle: Text(desc),
                        ),
                      ),
                    );
                  },
                ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NoteScreen(),
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: color,
      ),
    );
  }
}
