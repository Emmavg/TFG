// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:plantag/widgets/calendario.dart';

// ------------------------------------- Clase para la lista-------------------------------------------------//
class VistaLista2 extends StatelessWidget {
  const VistaLista2({super.key});
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      // ------------------------- Posteriormente implementar la barra de index ---------------//
      appBar: AppBar(
        title: const Text('Lista de tareas'),

      ),

      
      
      // -------------------------- Lista ---------------------------------------//
      body:
  
      Row(
      children: [
        const Expanded(
          // -------------- El lado izquierdo es más pequeño que el derecho con el valor del flex -----------------
          flex: 2,
          child: Calendario() 
        ),
        Expanded(
          flex: 4,
          child: 
          // En caso de que no tenga ningun hijo porque no hay ninguna tarea que salga algo
          false ? const PageEmpty() : 
          
          ListView.builder(
            // Numero de tareas
            itemCount: 10,
            itemBuilder:((context, index) => ListTile(
            title: Text("Tarea $index"),
            leading: const Icon(Icons.check_circle_outline_outlined, color:  Colors.green,),
            trailing: const Icon(Icons.delete, color:  Colors.red,),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: const [
                  Text("date ", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Contenido")
                ],
              ),
            ),
          
          )))
        ),
      ],
    ),
    // ---------------------- Boton para añadir tareas --------------------//
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.deepPurple,
      child: const Icon(Icons.add_task)
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  
}

class PageEmpty extends StatelessWidget {
  const PageEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center (
        child: Text("No tienes tareas pendientes",
        style: TextStyle(color: Colors.purple, fontStyle: FontStyle.italic, fontSize: 20))
      ),
    );
  }
}
