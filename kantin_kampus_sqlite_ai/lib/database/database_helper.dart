
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/pesanan.dart';

class DatabaseHelper {
  // Instance singleton
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  // Constructor private
  DatabaseHelper._init();

  // Getter database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('kantin_kampus.db');
    return _database!;
  }

  // Membuka database
  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final pathDB = join(dbPath, fileName);

    return await openDatabase(
      pathDB,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Menambahkan pesanan ke database

Future<int> tambahPesanan(Pesanan pesanan) async {
  final db = await database;

  return await db.insert(
    'pesanan',
    pesanan.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


  // Membuat tabel pesanan
  Future<void> _createDB(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE pesanan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ringkasan_item TEXT NOT NULL,
        total_item INTEGER NOT NULL,
        total_harga REAL NOT NULL,
        tanggal TEXT NOT NULL
      )
    ''');
  }
}
