class Tarea {
  int? id;
  final String titulo;
  final String descripcion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String categoria;
  final int dificultad;
  final String imagen;
  final int prioridad;
  final int hecha;

  Tarea({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.categoria,
    required this.dificultad,
    required this.imagen,
    required this.prioridad,
    required this.hecha,
  });



  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin' : fechaFin.toIso8601String(),
      'categoria': categoria,
      'dificultad': dificultad,
      'imagen': imagen,
      'prioridad': prioridad,
      'hecha':hecha,
    };
  }
}
