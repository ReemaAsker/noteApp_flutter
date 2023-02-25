import 'package:noteapp/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;
  static final String title = "title";
  static final String desc = 'desc';
  static final String creationDate = 'creationDate';
  static final String color = 'color';

//get Database
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

//Open a connection and create table notes
  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: (db, version) async {
      await db.execute(
          ' CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,desc TEXT,creationDate TEXT,color TEXT)');
    }, version: 1);
  }

//insert into table notes
  addNewNote(NoteModel note) async {
    final db = await database;
    db!.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//Retrieve table
  Future<List<NoteModel>?> getNotes() async {
    final db = await database;

    final List<Map<String, dynamic>> map = await db!.query('notes');

    if (map.length == 0) {
      return null;
    }

//Convert List of Map to List of NoteModel
    return List.generate(map.length, (i) {
       NoteModel nM;
      nM = NoteModel(map[i]['title'], map[i]['desc'], map[i]['creationDate'],
          map[i]['color']);
      nM.addId(map[i]['id']);
      return nM;
      
    });
  }

//Update notemodel
  Future<void> updateNote(NoteModel note) async {
    final db = await database;

    await db!.update(
      "notes",
      note.toMap(),
      where: 'id=?', //////////////
      whereArgs: [note.id],
    );
  }

//delete a note
  Future<void> deleteNote(int id) async {
    final db = await database;
    await db!.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
