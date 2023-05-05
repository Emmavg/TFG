import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantag/database_helper.dart';
import 'package:intl/intl.dart';
import '../models/lista.dart';
import '../models/tarea.dart';

class DetallesTarea extends StatelessWidget {
  final Lista tarea;

  DetallesTarea({required this.tarea});
  
  @override
  Widget build(BuildContext context) {
    Future<Tarea?> tareaDBFuture = SQLHelper.buscarTarea(tarea.titulo, tarea.descripcion);

    return Scaffold(
     appBar: AppBar(
        backgroundColor: const Color.fromRGBO(163, 238, 176, 1),
        //backgroundColor: const Color.fromARGB(214, 220, 255, 100),
        toolbarHeight: 60,
        // Le añadimos sombra a la parte de debajo de la barra
        elevation: 5,
      ),
      body: FutureBuilder<Tarea?>(
        future: tareaDBFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Text('Error al buscar la tarea en la base de datos');
          }

          Tarea tareaDB = snapshot.data!;

          return Card(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Mostrar la imagen de la tarea
      // tareaDB.imagen != null
      //     ? Image.memory(tareaDB.imagen!)
      //     : SizedBox.shrink(),

      // Mostrar el título de la tarea
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          tareaDB.titulo,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      // Mostrar la descripción de la tarea
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          tareaDB.descripcion,
          style: TextStyle(fontSize: 16),
        ),
      ),

      // Mostrar la categoría y dificultad de la tarea en una fila
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.category),
            SizedBox(width: 8),
            Text(tareaDB.categoria),
            SizedBox(width: 16),
            Icon(Icons.bar_chart),
            SizedBox(width: 8),
            Text('${tareaDB.dificultad}/5'),
          ],
        ),
      ),

      // Mostrar la prioridad de la tarea
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.warning),
            SizedBox(width: 8),
            Text('Prioridad ${tareaDB.prioridad}'),
          ],
        ),
      ),

      // Mostrar las fechas de la tarea en una columna
     Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fecha de inicio: ${DateFormat.yMMMMd().format(tareaDB.fechaInicio)}'),
          Text('Fecha de fin: ${DateFormat.yMMMMd().format(tareaDB.fechaFin)}'),
        ],
        ),
      ),
    ],
  ),
);
        },
      ),
    );
  }
}