import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static const _databaseName = "tareas_database.db";
  static const _databaseVersion = 1;

  static const table = 'tareas';

  static const columnId = '_id';
  static const columnTitulo = 'titulo';
  static const columnDescripcion = 'descripcion';
  static const columnHecha = 'hecha';
  static const columnFechaIni = 'fecha_ini';
  static const columnFechaFin = 'fecha_fin';
  static const columnCategoria = 'categoria';
  static const columnDificultad = 'dificultad';
  static const columnImagen = 'imagen';
  static const columnPrioridad = 'prioridad';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnTitulo TEXT NOT NULL,
        $columnDescripcion TEXT NOT NULL,
        $columnHecha INTEGER NOT NULL,
        $columnFechaIni TEXT NOT NULL,
        $columnFechaFin TEXT NOT NULL,
        $columnCategoria TEXT NOT NULL,
        $columnDificultad INTEGER NOT NULL,
        $columnImagen BLOB,
        $columnPrioridad INTEGER NOT NULL
      )
      ''');
  }

  Future<int> insertar(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> listarTodas() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> actualizar(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> borrar(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}