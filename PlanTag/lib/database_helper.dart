import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  // --------------------------- Creación de tabla ------------------------//
  static Future<void> createTables(Database database) async {
    await database.execute("""
      CREATE TABLE tareas(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        titulo TEXT,
        descripcion TEXT,
        fechaInicio DATE,
        fechaFin DATE,
        categoria TEXT,
        dificultad INTEGER,
        imagen BLOB,
        prioridad INTEGER
      )
    """);
  }

  // --------------------------- Abrir base  ------------------------//
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tareas_database.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // --------------------------- Insertar tarea  ------------------------//

  static Future<int> insertarTarea(Map<String, dynamic> data) async {
    final db = await SQLHelper.db();
    final id = await db.insert('tareas', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Other CRUD operations (read, update, delete) can be implemented in a similar manner
}
