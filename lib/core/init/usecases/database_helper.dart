import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        type TEXT,
        muscle TEXT,
        equipment TEXT,
        difficulty TEXT,
        instructions TEXT,
        groupName TEXT
      )
    ''');
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    final Database db = await database;
    return await db.insert('items', item);
  }

  Future<List<Map<String, dynamic>>> getAllItems() async {
    final Database db = await database;
    return await db.query('items');
  }

  Future<int> updateItem(Map<String, dynamic> item) async {
    final Database db = await database;
    return await db.update(
      'items',
      item,
      where: 'id = ?',
      whereArgs: [item['id']],
    );
  }

  Future<int> deleteItem(int id) async {
    final Database db = await database;
    return await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
