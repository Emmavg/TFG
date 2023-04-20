import 'package:flutter/material.dart';

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
        title: Text('Lista'),
      ),
      body: ListView.builder(
        // -------------------------- Lista ---------------------------------------//
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
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // ---------------------- Boton para añadir tareas --------------------//
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_task),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
