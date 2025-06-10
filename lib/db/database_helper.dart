import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _dbName = 'auth_app.db';
  static const _dbVersion = 1;
  static const _tableName = 'users';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(_tableName, user);
  }

  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
      String email, String password) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<bool> emailExists(String email) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }
}
