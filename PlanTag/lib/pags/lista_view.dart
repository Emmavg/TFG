// ignore_for_file: dead_code, unnecessary_null_comparison
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantag/main.dart';
import 'package:plantag/models/lista.dart';
import 'package:plantag/pags/index.dart';
import 'package:plantag/pags/nueva_tarea.dart';
import 'package:plantag/widgets/calendario.dart';
import 'package:plantag/models/tarea.dart';
import 'package:plantag/database_helper.dart';
import 'package:plantag/widgets/dialogo.dart';
import 'package:plantag/widgets/dialogo_tareas.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'detalles_tarea.dart';

// ------------------------------------- Clase para la lista-------------------------------------------------//
class VistaLista2 extends StatefulWidget {
  const VistaLista2({Key? key}) : super(key: key);

  @override
  State<VistaLista2> createState() => _VistaLista2State();
}

class _VistaLista2State extends State<VistaLista2> {
  // Con el ctrl + . encima del statefull lo hemos podido convertir a stateful widget para que los objetos puedan realizar acciones
  // En este caso la lista desplegable de la barra de nav

  // Creamos la propiedad para que el valor del dropdown item cambie cuando se selecciona
  String _orderSelected = "";
  bool _mostrarImg = true;
  bool _loading = true;
  List<Tarea> tareas = [];
  List<Tarea> tareasFiltradas = [];
  @override
  void initState() {
    super.initState();
    cargarTareas();
   
  }
    
//     tareas.addAll([
    
//      Lista(time: DateTime.now(), titulo: "Test 1", descripcion: "Trabajo"),
//      Lista(time: DateTime.now(), titulo: "Test 2", descripcion: "Trabajo"),
//      Lista(time: DateTime.now(), titulo: "Test 3", descripcion: "Trabajo"),
//     Lista(time: DateTime.now(), titulo: "Test 4", descripcion: "Trabajo"),

    
//  ]);
//   tareasFiltradas = tareas;

//   inicializarTareas();


  Future<void> cargarTareas() async {
      final lista = SQLHelper.tareas();
      lista.then((miLista) {
        setState(() {
          tareas = miLista;
          tareasFiltradas = tareas;
          _loading = false;
        });
      });
    }


  // Creamos la funcion para establecer la fecha y se la pasamos como parametro al content del dialogo
  // fechaSeleccionadaDialogo(PickerDateRange fechaSelec){
  //     _fechaSeleccionada = fechaSelec;
  // }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ),
        );
        return false;
      },
      child: 
     Scaffold(
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
                      onChanged: (value) {
                        _mostrarImg = value!;
                        setState(() {});
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

        backgroundColor: const Color.fromRGBO(163, 238, 176, 1),        toolbarHeight: 60,
        // Le añadimos sombra a la parte de debajo de la barra
        elevation: 5,
      ),

      // -------------------------- Lista ---------------------------------------//
      body:_loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          :  (tareas.isNotEmpty) ?
      
      Row(
        children: [
          // const Expanded(
          //     // -------------- El lado izquierdo es más pequeño que el derecho con el valor del flex -----------------
          //     flex: 2,
          //     child: Calendario()),
          Expanded(
              flex: 4,
              child:
                  // En caso de que no tenga ningun hijo porque no hay ninguna tarea que salga algo
                  tareasFiltradas.isEmpty
                      ? const PageEmpty()
                      : ListView.builder(
                          // Numero de tareasFiltradas
                          itemCount: tareasFiltradas.length,
                          itemBuilder: ((context, index) {
                          final tarea = tareasFiltradas[index];
                          String dificultadString = ''; 
                          if (tarea.hecha == 1) {
                            if(tarea.imagen == "Rosa")
                              dificultadString = "assets/images/rosa.png";
                            else{
                              if(tarea.imagen=="Tulipan")
                                dificultadString = "assets/images/tulipan.png";
                              else{
                                if (tarea.imagen =="Hibisco")
                                   dificultadString = "assets/images/hibisco.png";
                                else{
                                  if(tarea.imagen=="Margarita")
                                    dificultadString = "assets/images/margarita.png";
                                  else{
                                    dificultadString = "assets/images/lila.png";
                                  }
                                }
                                
                              }
                            }
                          } 
                          else { // si no esta hecha y se ha pasao se marchita
                          DateTime hoy = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
                            if(tarea.fechaFin.isBefore(hoy)){
                              dificultadString = "assets/images/marchita.png";
                            }
                            else{
                            switch (tarea.dificultad) {
                              case 1:
                                dificultadString = "assets/images/planta1.png";
                                break;
                              case 2:
                                dificultadString = "assets/images/planta2.png";
                                break;
                              case 3:
                                dificultadString = "assets/images/planta3.png";
                                break;
                              case 4:
                                dificultadString = "assets/images/planta4.png";
                                break;
                              case 5:
                                dificultadString = "assets/images/planta5.png";
                                break;
                            }}
                          }
                          return ListTile(
                                title: Card(
                                  color: const Color.fromRGBO(214, 220, 255, 1),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AnimatedContainer(
                                            duration:
                                                const Duration(milliseconds: 280),
                                            width: _mostrarImg ? 58 : 0,
                                            child: Image.asset(
                                              dificultadString,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${tareasFiltradas[index].fechaInicio.day} / ${tareasFiltradas[index].fechaInicio.month}",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 90, 90, 90),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    tareasFiltradas[index].titulo,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    tareasFiltradas[index].descripcion.length > 25
                                                        ? tareasFiltradas[index].descripcion.substring(0, 25) + "..."
                                                        : tareasFiltradas[index].descripcion,
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(255, 90, 90, 90),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () => _mostrarDetallesTarea(context, tarea),
                                  leading: GestureDetector(
                                    onTap: () {
                                      log('tarea hecha ${tarea.titulo}');
                                      SQLHelper.marcarTareaComoHecha(tarea.id);
                                      
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const VistaLista2(),
                                        ),
                                      );
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('¿Está seguro de que desea eliminar la tarea?'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Cancelar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Eliminar'),
                                                onPressed: () {
                                                  SQLHelper.eliminarTarea(tarea.id);
                                                  log('tarea eliminada ${tarea.titulo}');
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const VistaLista2(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                    ),
                  ],
                )
              : const PageEmpty(),
      // ---------------------- Boton para añadir tareas --------------------//
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Cuando pulsamos el botón muestra el dialogo creando una función para ello
          // showCupertinoDialog(
          //     // El barrier es para especificar que cuando toque otra zona de la pantalla se cierra
          //     barrierDismissible: false,
          //     context: context,
          //     builder: (context) {
          //       return DialogoTareas(fechaSeleccionada: null);
          //     });
          //  Tarea tarea = Tarea(
          //    titulo: "Test Irune",
          //   descripcion: "Comprar comida para la semana",
          //    fechaInicio: DateTime(2023, 5, 24),
          //    fechaFin: DateTime(2023, 5, 30),
          //    categoria: "Compras",
          //    dificultad: 3,
          //    imagen: "https://example.com/image.png",
          //    prioridad: 2,
          //    hecha:0,
          //  );
          //  SQLHelper.insertarTarea(tarea);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NuevaTarea(),
            ),
          ).then((value) {
            if (value == true) {
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => const VistaLista2(),
            ),);
            }
          });

        },
        backgroundColor: Colors.deepPurple,
        tooltip: 'Añadir Tarea',
        child: const Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     ) );
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
      child: Center(
          child: Text("No tienes tareas pendientes",
              style: TextStyle(
                  color: Color.fromARGB(255, 38, 107, 38),
                  fontStyle: FontStyle.italic,
                  fontSize: 20))),
    );
  }
}


// Cuando le das sal boton de cambiar a la vista de tareas te filtra por aquellas que correspondan con el rango de fechas seleccionadas
List<Lista> tareasFiltradas = [];
List<Lista> tareas = [];





void _mostrarDetallesTarea(BuildContext context, Tarea tarea) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetallesTarea(tarea: tarea),
    ),
  );
}

