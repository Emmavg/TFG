import 'package:flutter/material.dart';
import 'package:plantag/widgets/calendario.dart';
import 'package:plantag/pags/vista_lista.dart';
import '../main.dart';
import '../widgets/logo.dart';
import 'lista_view.dart';

class Index extends StatefulWidget {
  const Index({
    super.key,
    required this.widget,
  });

  final MyHomePage widget;

  // Con el ctrl + . encima del statefull lo hemos podido convertir a stateful widget para que los objetos puedan realizar acciones
  // En este caso la lista desplegable de la barra de nav
  @override
  State<Index> createState() => _IndexState();
}

// ********************************************************** CLASE PRINCIPAL **********************************************

class _IndexState extends State<Index> {
// Creamos la propiedad para que el valor del dropdown item cambie cuando se selecciona
  String _orderSelected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
// ********************************************************** Barra superior **********************************************

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Le ponemos el título asignado arriba en el widget + "app"
            Text(
              widget.widget.title,
              style: const TextStyle(
                  fontSize: 20, color: Colors.white, fontFamily: 'Trajan Pro'),
            ),
            const Text(
              'App',
              style: TextStyle(
                  fontSize: 20, color: Colors.grey, fontFamily: 'Trajan Pro'),
            ),
          ],
        ),

        // -------------------------------------------- ELEMENTOS QUE TIENEN ACCIONES ---------------------------------------
        actions: [
          Row(
            children: [
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

      // ********************************************************** BODY **********************************************
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            // Dentro del contenedor le metemos la clase que muestra el calendario
            Expanded(child: Calendario())
          ],
        ),
      ),
      
      
      // ------------------------------ Boton vista de tareas ---------------------------//
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VistaLista2()),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.list_alt_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
