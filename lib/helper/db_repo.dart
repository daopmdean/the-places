import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DbRepo {
  static Future<sql.Database> getDb() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, v) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_long REAL, address TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await getDb();
    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await getDb();
    return sqlDb.query(table);
  }
}
