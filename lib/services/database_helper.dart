import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'devices.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE devices(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        ip_address TEXT,
        last_connected TEXT
      )
    ''');
  }

  Future<int> insertDevice(Map<String, dynamic> device) async {
    Database db = await database;
    return await db.insert('devices', device);
  }

  Future<List<Map<String, dynamic>>> getDevices() async {
    Database db = await database;
    return await db.query('devices');
  }
}
