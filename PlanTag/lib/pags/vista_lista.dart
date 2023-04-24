import 'package:flutter/material.dart';
import 'package:plantag/models/tarea.dart';
import 'package:plantag/database_helper.dart';
// ------------------------------------- Clase para la lista-------------------------------------------------//
class VistaLista extends StatelessWidget {
  //-------------------------------------Por ahora elementos de prueba-----------------------------------------//
  final List<Map<String, dynamic>> items = [
    {
      'image': 'https://via.placeholder.com/80',
      'title': 'Tarea 1',
    },
    {
      'image': 'https://via.placeholder.com/80',
      'title': 'Tarea 2',
    },
    {
      'image': 'https://via.placeholder.com/80',
      'title': 'Tarea 3',
    },
    {
      'image': 'https://via.placeholder.com/80',
      'title': 'Tarea 4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ------------------------- Posteriormente implementar la barra de index ---------------//
      appBar: AppBar(
        title: const Text('Lista'),
      ),
      
      // -------------------------- Lista ---------------------------------------//
      body: ListView.builder( 
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: <Widget>[
                Image.network(items[index]['image']),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    items[index]['title'],
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // ---------------------- Boton para añadir tareas --------------------//
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Tarea tarea = Tarea(
              id: 1,
              titulo: "Comprar comida",
              descripcion: "Comprar comida para la semana",
              fechaInicio: DateTime(2023, 4, 24),
              fechaFin: DateTime(2023, 4, 30),
              categoria: "Compras",
              dificultad: 3,
              imagen: "https://example.com/image.png",
              prioridad: 2,
            );
        SQLHelper.insertarTarea(tarea);

        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add_task)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
