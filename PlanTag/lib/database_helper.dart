import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:plantag/models/tarea.dart';

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
  static Future<Database> _db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tareas_database.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // --------------------------- Insertar tarea  ------------------------//

  static Future<int> insertarTarea(Tarea tarea) async {
    final db = await SQLHelper._db();
    final id = await db.insert('tareas', tarea.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

}
