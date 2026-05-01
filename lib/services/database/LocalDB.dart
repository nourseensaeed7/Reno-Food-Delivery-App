import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static Database? _db;

  // Open (or create) the local database
  static Future<Database> get database async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'orders.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create orders table with: id, date, receipt text, and synced flag
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            receipt TEXT,
            synced INTEGER DEFAULT 0
          )
        ''');
      },
    );
    return _db!;
  }

  // Save an order locally (synced = 0 means not yet sent to Firebase)
  static Future<void> saveOrder(String receipt) async {
    final db = await database;
    await db.insert('orders', {
      'date': DateTime.now().toIso8601String(),
      'receipt': receipt,
      'synced': 0,
    });
  }

  // Get all orders that haven't been synced to Firebase yet
  static Future<List<Map<String, dynamic>>> getUnsyncedOrders() async {
    final db = await database;
    return await db.query('orders', where: 'synced = ?', whereArgs: [0]);
  }

  // Mark an order as synced after it's been sent to Firebase
  static Future<void> markSynced(int id) async {
    final db = await database;
    await db.update('orders', {'synced': 1}, where: 'id = ?', whereArgs: [id]);
  }
}