import 'dart:io';
import 'package:didaque_flutter/model/biblia.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "DidaqueDB.db";

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
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "biblia.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }

    return await openDatabase(path, readOnly: true);
  }

//  getBiblia(String versao) async {
//    final db = await database;
//    var res =
//        await db.query("biblia", where: "volume = ?", whereArgs: [volume]);
//    return res.isNotEmpty ? Biblia.fromJson(res.first) : Null;
//  }
//
//  getTexto(final String bookId) async {
//    final db = await database;
//    var res = await db
//        .query("texto", where: "$columnBookId = ?", whereArgs: [bookId]);
//    return res.isNotEmpty ? Book.fromJson(res.first) : Null;
//  }
}
