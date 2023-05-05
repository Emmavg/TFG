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
            prioridad INTEGER
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
    ),
  );
}

  // --------------------------- Insertar tarea  ------------------------//

  static Future<int> insertarTarea(Tarea tarea) async {
    final db = await _db();
    final id = await db.insert('tareas', tarea.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
   
    // ---------------- prueba de irune pera ver si existe ------------------- //
    Future<List<Tarea>> lista = SQLHelper.tareas();
    lista.then((miLista) {
    Tarea primero = miLista[-1];
    print(primero.fechaInicio);
});
    return id;
  }
}
