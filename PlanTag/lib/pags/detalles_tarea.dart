import 'package:flutter/material.dart';
import 'package:plantag/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:plantag/pags/editar_tarea.dart';
import '../models/tarea.dart';

class DetallesTarea extends StatelessWidget {
  final Tarea tarea;

  const DetallesTarea({super.key, required this.tarea});

  @override
  Widget build(BuildContext context) {
    Future<Tarea?> tareaDBFuture =
        SQLHelper.buscarTarea(tarea.titulo, tarea.descripcion);

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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Text('Error al buscar la tarea en la base de datos');
          }

          Tarea tareaDB = snapshot.data!;

          return Card(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mostrar la imagen de la tarea
                  // tareaDB.imagen != null
                  //     ? Image.memory(tareaDB.imagen!)
                  //     : SizedBox.shrink(),

                  // Mostrar el título de la tarea
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      tareaDB.titulo,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Mostrar la descripción de la tarea
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      tareaDB.descripcion,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),

                  // Mostrar la categoría y dificultad de la tarea en una fila
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.category),
                        const SizedBox(width: 8),
                        Text(tareaDB.categoria),
                        const SizedBox(width: 16),
                        const Icon(Icons.bar_chart),
                        const SizedBox(width: 8),
                        Text('${tareaDB.dificultad}/5'),
                      ],
                    ),
                  ),

                  // Mostrar la prioridad de la tarea
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.warning),
                        const SizedBox(width: 8),
                        Text('Prioridad ${tareaDB.prioridad}'),
                      ],
                    ),
                  ),

                  // Mostrar las fechas de la tarea en una columna
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Fecha de inicio: ${DateFormat.yMMMMd().format(tareaDB.fechaInicio)}'),
                        Text(
                            'Fecha de fin: ${DateFormat.yMMMMd().format(tareaDB.fechaFin)}'),
                        const SizedBox(
                            height: 16), // Agregamos un espacio en blanco
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Agregamos un espacio en blanco
                            ElevatedButton(
                              onPressed: () {
                                // Acción al presionar el botón "Eliminar"
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          '¿Está seguro de que desea eliminar la tarea?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Eliminar'),
                                          onPressed: () {
                                            SQLHelper.eliminarTarea(tareaDB.id);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .red, // Color rojo para el botón "Eliminar"
                              ),
                              child: const Text('Eliminar'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Acción al presionar el botón "Editar"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditarTarea(tarea: tareaDB),
                                  ),
                                );
                              },
                              child: const Text('Editar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
