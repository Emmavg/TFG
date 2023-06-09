// ********************************************************** CLASE DIALOGO **********************************************
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../models/tarea.dart';
import 'package:plantag/database_helper.dart';
import 'package:intl/intl.dart';

class DialogoTareas extends StatefulWidget {
  DateTime? fechaSeleccionada;

  DialogoTareas({
    this.fechaSeleccionada,
    Key? key,
  }) : super(key: key);

  @override
  State<DialogoTareas> createState() => _DialogoTareasState();
}

class _DialogoTareasState extends State<DialogoTareas> {
  final _key = GlobalKey<FormState>();
  final List<String> _imagenes = ['Tulipan', 'Rosa', "Margarita", "Hibisco"];

  // Para saber siempre el tamaño de la columna del formulario de forma dinámica aunque vaya cambiando por la pantalla
  final _keyTamColum = GlobalKey<FormState>();

  final _nomFld = TextEditingController();
  final _descFld = TextEditingController();
  late DateTime _fechaFin = widget.fechaSeleccionada!;
  late String _imgFld;

  Future<void> _selectFechaFin(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaFin,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _fechaFin = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _imgFld = _imagenes[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Nueva tarea",
        textAlign: TextAlign.left,
      ),
      backgroundColor: const Color.fromARGB(255, 223, 255, 222), // your color

      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(40)), // change 40 to your desired radius

      // -------------- PÀRA QUE LOS BOTONES SALGAN ABAJO DEL DIALOG HAY QUE AÑADIRLOS COMO ACCIONES ----------------
      actions: [
        // -------------------------------------- Btns Formulario ----------------------------------------
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // ---------------------------------------- Btn Cancel --------------------------------------
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0, left: 15),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.close),
              label: const Text("Cancelar"),
              onPressed: () {
                // Cerramos la ventana cuando pulsemos el botón
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                side: const BorderSide(
                    width: 2.0, color: Color.fromARGB(255, 255, 9, 9)),
                foregroundColor: const Color.fromARGB(255, 255, 9, 9),
                // Forma de cuadrado circular al botón
                shape: const StadiumBorder(),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ---------------------------------------- Btn Ok --------------------------------------
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0, right: 10),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.done),
              label: const Text("Aceptar"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                // Forma de cuadrado circular al botón
                shape: const StadiumBorder(),
                side: const BorderSide(
                    width: 2.0, color: Color.fromARGB(255, 3, 223, 25)),
                //backgroundColor: Color.fromARGB(255, 94, 255, 110),
                // Color del texto
                foregroundColor: const Color.fromRGBO(5, 177, 22, 1),
              ),
              // --------------------------------- Metodo pulsar btn --------------------------------------
              onPressed: () {
                // Depende de si está definido el contexto o no y de si está o no asignada la key a este componente por lo que arriba lo evaluamos con una condicion
                // y ponemos la ! para decirle a flutter que nos aseguramos que recibe esa variable

                // print(_key.currentContext!.size);
                // Validamos si es correcto el formulario y están todos los campos rellenos o falta alguno obligatorio
                if (_key.currentState!.validate()) {
                  // Process data.
                  // Cerramos la ventana cuando pulsemos el botón
                  // Insertar tarea
                  Tarea tarea = Tarea(
                    titulo: _nomFld.text,
                    descripcion: _descFld.text,
                    fechaInicio: widget.fechaSeleccionada!,
                    fechaFin: _fechaFin,
                    categoria: "Otros",
                    dificultad: 3,
                    imagen: _imgFld,
                    prioridad: 3,
                    hecha: 0,
                  );
                  SQLHelper.insertarTarea(tarea);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ])
      ],

      // ------------------------------------------- CONSTRAINT LAYOUT  -------------------------------------------
      // Dependiendo de la pantalla, especificamos los tamaños estandar
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 200,
          maxWidth: 800,
          minHeight: 600,
          maxHeight: 1000,
        ),
        child: SizedBox(
          // Sacamos la altura y anchura del padre o de la ventana principal en este caso y le decimos que queremos ocupar un 40% de la misma
          width: MediaQuery.of(context).size.width * .4,
          height: MediaQuery.of(context).size.height * .4,

          // ----------------------------------------- FORMULARIO DEL DIALOGO ------------------------------------

          child: Form(
            // Le decimos a flutter que efectivamente le asignamos esta key al componente Form para poderlo evaluar abajo en el método de presionar el botón
            key: _key,
            // Para que sea más responsive, si no entra en la pantalla le metemos un scroll view al diálogo que solo aparece cuando sea necesario de forma automática
            child: SingleChildScrollView(
              child: Column(
                // Para saber el tamaño de un componente en particular solamente le estableces su key y lo evaluamos al presionar el botón por ejemplo
                key: _keyTamColum,
                children: [
                  // ------------------------------------------- Logo --------------------------------------------
                  //const LogoSettings(),

                  // -------------------------------------- TxtFld Nombre ----------------------------------------
                  TextFormField(
                    controller: _nomFld,
                    decoration: const InputDecoration(
                        labelText: "Nombre", border: OutlineInputBorder()),

                    // Validamos si es correcto ese campo o si está relleno en caso de ser obligatorio (Cuando se pulsa el botón abajo se valida)
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor introduce algo';
                      }
                      return null;
                    },
                  ),

                  // Le añadimos un espacio para que no estén tan pegados como si fuera un br
                  const SizedBox(height: 10),

                  // -------------------------------------- TxtFld Descripcion ----------------------------------------
                  TextFormField(
                    controller: _descFld,
                    maxLines: 3,
                    minLines: 3,
                    decoration: const InputDecoration(
                        labelText: "Descripción", border: OutlineInputBorder()),
                  ),

                  // Le añadimos un espacio para que no estén tan pegados como si fuera un br
                  const SizedBox(height: 10),

                  // ---------------------------------------- menu Img ----------------------------------------
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Planta'),
                    value: _imgFld,
                    items: _imagenes.map((String planta) {
                      return DropdownMenuItem<String>(
                        value: planta,
                        child: Text(planta),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione una planta';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _imgFld = value!;
                      });
                    },
                  ),

                  // Le añadimos un espacio para que no estén tan pegados como si fuera un br
                  const SizedBox(height: 35),

                  // -------------------------------------- Calendario ----------------------------------------
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Fecha fin'),
                    readOnly: true,
                    onTap: () => _selectFechaFin(context),
                    validator: (value) {
                      // ignore: unnecessary_null_comparison
                      if (_fechaFin == null) {
                        return 'Por favor ingrese una fecha de fin';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                      // ignore: unnecessary_null_comparison
                      text: _fechaFin != null
                          ? DateFormat.yMd().format(_fechaFin)
                          : '',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
