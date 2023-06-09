import 'package:flutter/material.dart';
import 'package:plantag/pags/categorias.dart';
import 'package:plantag/widgets/calendario.dart';
import 'package:plantag/database_helper.dart';
import 'package:plantag/models/tarea.dart';
import '../main.dart';
import 'lista_view.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
  @override
  Widget build(BuildContext context) {
    // ***************************** carga las tareas al principio :) ********************************************
    Future<List<Tarea>> lista = SQLHelper.tareas();
    lista.then((miLista) {
      // paso los elementos de tareas a appointments que se pueden meter en el calendario
      List<Appointment> appointments = [];

      for (Tarea tarea in miLista) {
        Appointment appointment = Appointment(
          startTime: tarea.fechaInicio,
          endTime: tarea.fechaFin,
          subject: tarea.titulo,
          notes: tarea.descripcion,
          color: Colors.blue,
        );

        appointments.add(appointment);
        //print(appointments[0].subject);
      }

      // aqui hay que cargar el calendario :)
    });
    return WillPopScope(
      onWillPop: () async {
        // Show dialog and handle user's choice
        bool exit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Seguro?"),
            content: const Text("Salir de Plantag?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
               onPressed: () {
                Navigator.of(context).pop(true);
                _exitApp();
              },
                child: const Text("Si"),
              ),
            ],
          ),
        );

        return exit; 
      },
      child: Scaffold(
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

        actions: [
          // IconButton(icon: const Icon(Icons.more_vert, color: Colors.white,), onPressed: () {

          SpeedDial(
            //Speed dial menu//margin bottom
            icon: Icons.more_vert, //icon on Floating action button

            // Cambiamos la direccion en la que se despliega
            direction: SpeedDialDirection.down,
            activeIcon: Icons.close, //icon when menu is expanded on button
            backgroundColor: const Color.fromARGB(
                214, 220, 255, 100), //background color of button
            foregroundColor: Colors.white, //font color, icon color in button
            activeBackgroundColor: const Color.fromARGB(
                255, 255, 37, 37), //background color when menu is expanded
            activeForegroundColor: Colors.white,
            childrenButtonSize: const Size(60, 60),
            buttonSize: const Size(40, 40),
            visible: true,
            closeManually: false,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,

            animationDuration: const Duration(milliseconds: 150),
            // Tambien lo separa del padre
            spaceBetweenChildren: 10,

            elevation: 8.0, //shadow elevation of button
            shape: const CircleBorder(), //shape of button

            children: [
              // -------------------------------------- MENU DESPLEGABLE AYUDAS ------------------------------

              // Categorías
              SpeedDialChild(
                child: const Icon(
                  Icons.format_list_bulleted,
                  size: 30,
                ),
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
                label: 'Categorías',
                labelStyle: const TextStyle(fontSize: 15.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriasPage(),
                    ),
                  );
                },
                onLongPress: () {},
              ),

              // El que está más lejos del principal: Ayuda
              SpeedDialChild(
                child: const Icon(
                  Icons.question_mark_rounded,
                  size: 30,
                ),
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
                label: 'Ayuda',
                labelStyle: const TextStyle(fontSize: 15.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VistaLista2()),
                  );
                },
                onLongPress: () {},
              ),
            ],
          ),
        ],

        backgroundColor: const Color.fromRGBO(163, 238, 176, 1),
        //backgroundColor: const Color.fromARGB(214, 220, 255, 100),
        toolbarHeight: 60,
        // Le añadimos sombra a la parte de debajo de la barra
        elevation: 5,
      ),

      // ********************************************************** BODY **********************************************
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dentro del contenedor le metemos la clase que muestra el calendario
            Expanded(
                child: Calendario(
              botones: true,
            ))
          ],
        ),
      ),

      // ------------------------------ Boton vista de tareas ---------------------------//
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("Index");
          //inicializarTareas();
          //print(tareas.length);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VistaLista2(),
            ),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.list_alt_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
  void _exitApp() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}
}
