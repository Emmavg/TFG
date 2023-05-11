import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tarea.dart';
import 'package:plantag/database_helper.dart';


class NuevaTarea extends StatefulWidget {
  const NuevaTarea({Key? key}) : super(key: key);

  @override
  _NuevaTarea createState() => _NuevaTarea();
}

class _NuevaTarea extends State<NuevaTarea> {
  final _formKey = GlobalKey<FormState>();
  late String _titulo;
  late String _descripcion;
  late String _categoria;
  late int _dificultad;
  late String _imagen;
  late int _prioridad;
  late DateTime _fechaInicio = DateTime.now();
  late DateTime _fechaFin = DateTime.now();

  Future<void> _selectFechaInicio(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _fechaInicio = picked;
      });
    }
  }

  Future<void> _selectFechaFin(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        backgroundColor: const Color.fromRGBO(163, 238, 176, 1),
        //backgroundColor: const Color.fromARGB(214, 220, 255, 100),
        toolbarHeight: 60,
        // Le añadimos sombra a la parte de debajo de la barra
        elevation: 5,
      ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Titulo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un titulo';
                }
                return null;
              },
              onSaved: (value) => _titulo = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descripcion'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripcion';
                }
                return null;
              },
              onSaved: (value) => _descripcion = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Categoria'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una categoria';
                }
                return null;
              },
              onSaved: (value) => _categoria = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Dificultad'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una dificultad';
                }
                if (int.tryParse(value) == null) {
                  return 'La dificultad debe ser un número entero';
                }
                return null;
              },
              onSaved: (value) => _dificultad = int.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Imagen'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una imagen';
                }
                return null;
              },
              onSaved: (value) => _imagen = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Prioridad'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una prioridad';
                }
                if (int.tryParse(value) == null) {
                  return 'La prioridad debe ser un número entero';
                }
                return null;
              },
              onSaved: (value) => _prioridad = int.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Fecha inicio'),
              readOnly: true,
              onTap: () => _selectFechaInicio(context),
              validator: (value) {
                if (_fechaInicio == null) {
                  return 'Por favor ingrese una fecha de inicio';
                }
                return null;
              },
              controller: TextEditingController(
                text: _fechaInicio != null
                    ? DateFormat.yMd().format(_fechaInicio)
                    : '',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Fecha fin'),
              readOnly: true,
              onTap: () => _selectFechaFin(context),
              validator: (value) {
                if (_fechaFin == null) {
                  return 'Por favor ingrese una fecha de fin';
                }
                return null;
              },
              controller: TextEditingController(
                text: _fechaFin != null ? DateFormat.yMd().format(_fechaFin) : '',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final tarea = Tarea(
                    titulo: _titulo,
                    descripcion: _descripcion,
                    fechaInicio: _fechaInicio, fechaFin: _fechaFin,
                    categoria: _categoria,
                    dificultad: _dificultad,
                    imagen: _imagen,
                    prioridad: _prioridad,
                    hecha: 0,
                  );
                  SQLHelper.insertarTarea(tarea);
                  Navigator.pop(context);

                }
              },
            child: Text('Plantar'),
          ),
        ],
      ),),),
    );
}}