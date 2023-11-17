import 'package:path/path.dart';
import 'package:ringo/model/generic_model.dart';
import 'package:sqflite/sqflite.dart';

class RingoDbProvider {
  static const tableName = 'generic_value_table';
  static const dbName = 'ringo.db';
  static const querySql =
      'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, value REAL, type INTEGER)';
  static Database? db;
  double? getValue;

  static Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(querySql);
      },
      version: 1,
    );
  }

  Future insert(GenericModel model) async {
    db = await getDatabase();
    db!.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future delete(GenericModel model) async {
    db = await getDatabase();
    db!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future update(GenericModel model) async {
    db = await getDatabase();
    db!.update(
      tableName,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<GenericModel> readById(int id) async {
    db = await getDatabase();
    final data = await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    return GenericModel.fromMap(data[0]);
  }

  Future<List<GenericModel>> readAll() async {
    db = await getDatabase();
    final data = await db!.query(tableName);
    return List.generate(
      data.length,
      (index) => GenericModel.fromMap(data[index]),
    );
  }

  static Future<double> getTotalAmount(Database database) async {
    final List<Map<String, dynamic>> result =
        await database.rawQuery('SELECT SUM(value) as total FROM $tableName');
    return result.first['total'] as double;
  }

  static Future<List<Map<String, dynamic>>> getTotalByDate(Database database) async {
    final List<Map<String, dynamic>> result = await database.rawQuery(
        'SELECT date, SUM(value) as total FROM $tableName GROUP BY date');
    return result;
  }
}
