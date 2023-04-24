import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

 // --------------------------- lista de tareas  ------------------------//
 static Future<List<Tarea>> tareas() async {
    final db = await _db();
    final List<Map<String, dynamic>> tareasMap = await db.query("tareas");

    return List.generate(tareasMap.length,
            (i) => Tarea(
              id: tareasMap[i]['id'],
              titulo: tareasMap[i]['titulo'],
              descripcion: tareasMap[i]['descripcion'],
              fechaInicio: tareasMap[i]['fechaInicio'],
              fechaFin: tareasMap[i]['fechaFin'],
              categoria: tareasMap[i]['categoria'],
              dificultad: tareasMap[i]['dificultad'],
              imagen: tareasMap[i]['imagen'],
              prioridad: tareasMap[i]['prioridad'],
            ));
  }

  // --------------------------- Insertar tarea  ------------------------//

  static Future<int> insertarTarea(Tarea tarea) async {
    final db = await _db();
    final id = await db.insert('tareas', tarea.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
        
    return id;
  }


}
