import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/db/user_dbModel.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('userData.db');
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableUser ( 
  ${UserFields.id} $idType,
  ${UserFields.username} $textType,
  ${UserFields.email} $textType,
  ${UserFields.number} $integerType,
  ${UserFields.pass} $textType
  )
''');
  }

  Future<UserData> create(UserData user) async {
    final db = await instance.database;
    final id = await db.insert(tableUser, user.toJson());
    return user.copy(id: id);
  }

  Future<UserData> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserData.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<UserData>> readAll() async {
    final db = await instance.database;
    final result = await db.query(tableUser);
    return result.map((json) => UserData.fromJson(json)).toList();
  }

  Future<int> update(UserData user) async {
    final db = await instance.database;
    return db.update(
      tableUser,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableUser,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<UserData?> getUserByEmail(String email) async {
    final db = await instance.database;
    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.email} = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return UserData.fromJson(maps.first);
    }
    return null;
  }
}
