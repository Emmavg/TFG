class Tarea {
  int id;
  final String titulo;
  final String descripcion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String categoria;
  final int dificultad;
  final String imagen;
  final int prioridad;

  Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.categoria,
    required this.dificultad,
    required this.imagen,
    required this.prioridad,
  });



  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin' : fechaFin.toIso8601String(),
      'categoria': categoria,
      'dificultad': dificultad,
      'imagen': imagen,
      'prioridad': prioridad
    };
  }
}
