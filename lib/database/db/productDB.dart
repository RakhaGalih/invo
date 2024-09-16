import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/db/product_dbModel.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();

  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('productList.db');
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
CREATE TABLE $tableProduct ( 
  ${ProductFields.id} $idType,
  ${ProductFields.nameProduct} $textType,
  ${ProductFields.category} $textType,
  ${ProductFields.quantity} $integerType,
  ${ProductFields.codeProduct} $textType,
  ${ProductFields.price} $textType,
  ${ProductFields.location} $textType,
  ${ProductFields.desc} $textType,
  ${ProductFields.image} $textType
  )
''');
  }

  Future<ProductList> create(ProductList product) async {
    final db = await instance.database;
    final id = await db.insert(tableProduct, product.toJson());
    return product.copy(id: id);
  }

  Future<ProductList> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableProduct,
      columns: ProductFields.values,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ProductList.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ProductList>> readAll() async {
    final db = await instance.database;
    final result = await db.query(tableProduct);
    return result.map((json) => ProductList.fromJson(json)).toList();
  }

  Future<int> update(ProductList product) async {
    final db = await instance.database;
    return db.update(
      tableProduct,
      product.toJson(),
      where: '${ProductFields.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableProduct,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
