import 'dart:io';
import 'package:didaque_flutter/model/bible.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "DidaqueDB.db";
  static final _databaseVersion = 1;
  static final tableBook = 'book';
  static final tableBible = 'bible';

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
      await db.execute("CREATE TABLE $tableBook ("
          "id INTEGER PRIMARY KEY,"
          "bible_id INTEGER,"
          "$columnBookName TEXT,"
          "$columnBookId TEXT,"
          "$columnBookOrder TEXT,"
          "$columnChapterId TEXT,"
          "$columnChapterTitle TEXT,"
          "$columnVerseId TEXT,"
          "$columnVerseText TEXT,"
          "$columnParagraphNumber TEXT"
          ")");
      await db.execute("CREATE TABLE $tableBible ("
          "id INTEGER PRIMARY KEY,"
          "volume TEXT"
          ")");
    });
  }

  insert(Map<String, dynamic> object, String table) async {
    final db = await database;
    var res = await db.insert(table, object);
    return res;
  }

  getBibleByVolume(String volume) async {
    final db = await database;
    var res =
        await db.query(tableBible, where: "volume = ?", whereArgs: [volume]);
    return res.isNotEmpty ? Bible.fromJson(res.first) : Null;
  }

  getBook(final String bookId) async {
    final db = await database;
    var res = await db
        .query(tableBook, where: "$columnBookId = ?", whereArgs: [bookId]);
    return res.isNotEmpty ? Book.fromJson(res.first) : Null;
  }
}
