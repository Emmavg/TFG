class Tarea {
  int? id;
  String? titulo;
  String? descripcion;
  DateTime? fechaInicio = DateTime.now();
  DateTime? fechaFin = DateTime.now();
  String? categoria;
  int? dificultad;
  String? imagen;
  int? prioridad;

  Tarea(
      {this.id,
      this.titulo,
      this.descripcion,
      this.fechaInicio,
      this.fechaFin,
      this.categoria,
      this.dificultad,
      this.imagen,
      this.prioridad});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'categoria': categoria,
      'dificultad': dificultad,
      'imagen': imagen,
      'prioridad': prioridad
    };
  }
}
