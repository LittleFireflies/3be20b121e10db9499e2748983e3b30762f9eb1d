import 'package:kulina_app/data/models/product_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblCart = 'cart';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/kulina.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblCart (
             id INTEGER PRIMARY KEY,
             name TEXT,
             imageUrl TEXT,
             brandName TEXT,
             packageName TEXT,
             price INTEGER,
             rating REAL,
             date TEXT,
             quantity INTEGER
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> addToCart(ProductOrderTable productOrder) async {
    final db = await database;
    await db!.insert(_tblCart, productOrder.toJson());
  }

  Future<List<ProductOrderTable>> getCarts() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblCart);

    return results.map((res) => ProductOrderTable.fromJson(res)).toList();
  }
}