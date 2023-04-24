// ignore_for_file: dead_code
import 'package:flutter/material.dart';
import 'package:plantag/widgets/calendario.dart';
import 'package:plantag/models/tarea.dart';
import 'package:plantag/database_helper.dart';

// ------------------------------------- Clase para la lista-------------------------------------------------//
class VistaLista2 extends StatefulWidget {
  
  const VistaLista2({super.key});

  @override
  State<VistaLista2> createState() => _VistaLista2State();
}

class _VistaLista2State extends State<VistaLista2> {

   // Con el ctrl + . encima del statefull lo hemos podido convertir a stateful widget para que los objetos puedan realizar acciones
  // En este caso la lista desplegable de la barra de nav

  // Creamos la propiedad para que el valor del dropdown item cambie cuando se selecciona
  String _orderSelected = "";
  bool _mostrarImg = true;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      // ------------------------- Posteriormente implementar la barra de index ---------------//
      appBar: AppBar(
        title: const Text('Lista de tareas'),


       // -------------------------------------------- ELEMENTOS QUE TIENEN ACCIONES ---------------------------------------
        actions: [
          Row(
            children: [

              // ------------------------------------- Checkbox mostrar imagen ----------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Mostrar Imagen"),
                  Checkbox(
                    value: _mostrarImg, 
                    onChanged: (value){
                      _mostrarImg = value!;
                      setState(() {
                        
                      });
                  }),
                ],
              ),

              const SizedBox(width: 50),
              // ------------------------------ Lista desplegable seleccionar que tiene un filtro -------------------------
              DropdownButton(
                  items: <String>["Por fecha", "Por creación"]
                      .map((i) => DropdownMenuItem<String>(
                          value: i,
                          child: Text(i,
                              style:
                                  const TextStyle(color: Colors.deepOrange))))
                      .toList(),
                  // Le colocamos texto inicial al menú deslegable, si la propiedad orderselected es "" entonces le ponemos el txt de la const
                  hint: _orderSelected == ""
                      ? const Text(
                          "Seleccionar", style: TextStyle(color: Colors.black),

                          // Sino
                        )
                      : Text(_orderSelected,
                          style: const TextStyle(color: Colors.black)),

                  // --------------------------------- ACCION CUANDO SE SELECCIONE UN VALOR --------------------------
                  onChanged: (value) {
                    setState(() {
                      _orderSelected = value.toString();
                    });
                  }),

              
              // ---------------------- Colocamos un logo al lado del desplegable importando la clase-------------------
              //Expanded(child: LogoSettings())
            ],

          )
        ],

        backgroundColor: const Color.fromARGB(255, 78, 241, 190),
        toolbarHeight: 60,
        // Le añadimos sombra a la parte de debajo de la barra
        elevation: 5,
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
            title: Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      width: _mostrarImg ? 58 : 0,
                      image: const AssetImage("assets/images/rosa.png")
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tarea $index", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        Row(
                          children: const [
                            Text("date ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 90, 90, 90)),),
                            SizedBox(height: 30),
                            Text("Contenido", style: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Icon(Icons.check_circle_outline_outlined, color:  Colors.green,),
            ),
            trailing: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Icon(Icons.delete, color:  Colors.red,),
            ),
            ))
          )
        ),
      ],
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
