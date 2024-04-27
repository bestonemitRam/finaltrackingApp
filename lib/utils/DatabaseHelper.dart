import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'location_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS location_data (id INTEGER PRIMARY KEY, latitude REAL, longitude REAL, timestamp INTEGER)');
      },
    );
  }

  Future<void> insertLocationData(
      double latitude, double longitude, int timestamp) async 
      {
    final db = await database;
    await db.insert('location_data',
        {'latitude': latitude, 'longitude': longitude, 'timestamp': timestamp},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> fetchLocationData() async {
    final db = await database;
    return await db.query('location_data');
  }

    Future<void> deleteAllLocationData() async
     {
    final db = await database;
    await db.delete('location_data');
  }
}
