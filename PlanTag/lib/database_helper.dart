import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:plantag/models/tarea.dart';

class SQLHelper {
  // --------------------------- Abrir base  ------------------------//

  static Future<Database> _db() async {
    return openDatabase(join(await getDatabasesPath(), 'jaidb.db'),
        onCreate: (db, version) {
          db.execute("""
          CREATE TABLE categoria(            
              nombre TEXT PRIMARY KEY NOT NULL
            )
            """);
      return db.execute("""
          CREATE TABLE tareas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            descripcion TEXT,
            fechaInicio DATE,
            fechaFin DATE,
            categoria TEXT,
            dificultad INTEGER,
            imagen BLOB,
            prioridad INTEGER,
            hecha INTEGER
            )
          """);
    }, version: 1);
  }
  // ----------------------- Borrar base OJO! -----------------------
  static Future<void> eliminarBase() async {
  final db = await _db();
  db.execute("""
        DROP TABLE tareas;
        DROP TABLE categoria;
        """);
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
      hecha: tareasMap[i]['hecha'] ?? 0,
    ),
  );
}

  // --------------------------- Insertar tarea  ------------------------//

static Future<void> insertarTarea(Tarea tarea) async {
  final db = await _db();
  await db.insert('tareas', tarea.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
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
      hecha: tareaMap[0]['hecha'] ?? 1,
    );
  }


  // ----------------------- Borrar una tarea -----------------------
  static Future<void> eliminarTarea(int? id) async {
    // print(id); aqui llega bien el id
  final db = await _db();
  await db.delete('tareas', where: 'id = ?', whereArgs: [id]);
}


// ----------------------- Editar una tarea --------------------------
static Future<void> editarTarea(int? id, String titulo,String descripcion,DateTime fechaInicio,DateTime fechaFin,String categoria,int dificultad,String imagen,int prioridad, int hecha)async {
    final db = await _db();
    await db.update(
        'tareas',
        {
          'titulo': titulo,
          'descripcion': descripcion,
          'fechaInicio': fechaInicio.toIso8601String(),
          'fechaFin': fechaFin.toIso8601String(),
          'categoria': categoria,
          'dificultad': dificultad,
          'imagen': imagen,
          'prioridad': prioridad,
          'hecha': hecha,
        },
        where: 'id = ?',
        whereArgs: [id],
      );

    log("Tarea actualizada");
  }

// ----------------------- Marcar una tarea como hecha --------------------------
static Future<void> marcarTareaComoHecha(int? id) async {
  final db = await _db();
  await db.update(
    'tareas',
    {'hecha': 1},
    where: 'id = ?',
    whereArgs: [id],
  );
}

}
