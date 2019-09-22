import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "DidaqueDB.db";
  static final _databaseVersion = 1;
  static final table = 'bible';

  final String columnBookName = "book_name";
  final String columnBookId = "book_id";
  final String columnBookOrder = "book_order";
  final String columnChapterId = "chapter_id";
  final String columnChapterTitle = "chapter_title";
  final String columnVerseId = "verse_id";
  final String columnVerseText = "verse_text";
  final String columnParagraphNumber = "paragraph_number";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $table ("
          "id INTEGER PRIMARY KEY,"
          "$columnBookName TEXT,"
          "$columnBookId TEXT,"
          "$columnBookOrder TEXT,"
          "$columnChapterId TEXT,"
          "$columnChapterTitle TEXT,"
          "$columnVerseId TEXT,"
          "$columnVerseText TEXT,"
          "$columnParagraphNumber TEXT"
          ")");
    });
  }
}
