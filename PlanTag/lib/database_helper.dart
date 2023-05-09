import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:plantag/models/tarea.dart';

class SQLHelper {
  // --------------------------- Abrir base  ------------------------//

  static Future<Database> _db() async {
    return openDatabase(join(await getDatabasesPath(), 'tareas.db'),
        onCreate: (db, version) {
      return db.execute("""
          CREATE TABLE tareas(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            titulo TEXT,
            descripcion TEXT,
            fechaInicio DATE,
            fechaFin DATE,
            categoria TEXT,
            dificultad INTEGER,
            imagen BLOB,
            prioridad INTEGER,
            hecha INTEGER,
            )
          """);
    }, version: 1);
  }

  // --------------------------- lista de tareas  ------------------------//

static Future<List<Tarea>> tareas() async {
  final db = await _db();
  final List<Map<String, dynamic>> tareasMap = await db.query("tareas");
  return List.generate(
    tareasMap.length,
    (i) => Tarea(
      id: tareasMap[i]['id'],
      titulo: tareasMap[i]['titulo'],
      descripcion: tareasMap[i]['descripcion'],
      fechaInicio: tareasMap[i]['fechaInicio'] != null ? DateTime.parse(tareasMap[i]['fechaInicio']) : DateTime.now(),
      fechaFin: tareasMap[i]['fechaFin'] != null ? DateTime.parse(tareasMap[i]['fechaFin']) : DateTime.now(),
      categoria: tareasMap[i]['categoria'],
      dificultad: tareasMap[i]['dificultad'],
      imagen: tareasMap[i]['imagen'],
      prioridad: tareasMap[i]['prioridad'],
      hecha: tareasMap[i]['hecha'],
    ),
  );
}

  // --------------------------- Insertar tarea  ------------------------//

  static Future<int> insertarTarea(Tarea tarea) async {
    final db = await _db();
    final id = await db.insert('tareas', tarea.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    log("Se ha añadido la nueva tarea ${tarea.titulo}");
    return id;
  }

  // ------------- para que me devuelva toda la info de la tarea que quiero ----------
    static Future<Tarea?> buscarTarea(String nombre, String descripcion) async {
    final db = await _db();
    final List<Map<String, dynamic>> tareaMap = await db.query(
      'tareas',
      where: 'titulo = ? AND descripcion = ? ',
      whereArgs: [nombre, descripcion],
      limit: 1,
    );

    if (tareaMap.isEmpty) {
      return null;
    }

    return Tarea(
      id: tareaMap[0]['id'],
      titulo: tareaMap[0]['titulo'],
      descripcion: tareaMap[0]['descripcion'],
      fechaInicio: tareaMap[0]['fechaInicio'] != null ? DateTime.parse(tareaMap[0]['fechaInicio']) : DateTime.now(),
      fechaFin: tareaMap[0]['fechaFin'] != null ? DateTime.parse(tareaMap[0]['fechaFin']) : DateTime.now(),
      categoria: tareaMap[0]['categoria'],
      dificultad: tareaMap[0]['dificultad'],
      imagen: tareaMap[0]['imagen'],
      prioridad: tareaMap[0]['prioridad'],
      hecha: tareaMap[0]['hecha'],
    );
  }


  // ----------------------- Borrar una tarea -----------------------
  static Future<void> eliminarTarea(int? id) async {
  final db = await _db();
  await db.delete('tareas', where: 'id = ?', whereArgs: [id]);
}


// ----------------------- Editar una tarea --------------------------
static Future<void> editarTarea(Tarea tarea) async {
    final db = await _db();
    await db.update(
      'tareas',
      tarea.toMap(),
      where: 'id = ?',
      whereArgs: [tarea.id],
    );
    log("Tarea actualizada");
  }
}
