import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserDataDB {
  static Database? _dataBase;

  Future<Database> get dataBase async {
    _dataBase ??= await initDB();
    return _dataBase!;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'user_data.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE userData(
      id INTEGER PRIMARY KEY, 
      name TEXT, 
      email TEXT, 
      profileImage TEXT)
      ''');
  }

  Future<void> clearUserData() async {
    var db = await dataBase;
    await db.delete('userData');
  }

  Future<void> saveUserDataDB(
    String name,
    String email,
    String profileImage,
  ) async {
    var db = await dataBase;

    await db.transaction((txn) async {
      return await txn.rawInsert(
        '''INSERT INTO userData(
          name, 
          email, 
          profileImage) 
          VALUES(?, ?, ?)
          ''',
        [
          name,
          email,
          profileImage,
        ],
      );
    });
  }

  Future<List<Map>> getUserDataDB() async {
    var db = await dataBase;
    List<Map> list = await db.query('userData');
    return list;
  }
}