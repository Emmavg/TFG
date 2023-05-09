import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tarea.dart';
import 'package:plantag/database_helper.dart';


class EditarTarea extends StatefulWidget {
  final Tarea tarea;

  EditarTarea({required this.tarea});

  @override
  _EditarTareaState createState() => _EditarTareaState();
}

class _EditarTareaState extends State<EditarTarea> {
  final _formKey = GlobalKey<FormState>();

  late String _titulo;
  late String _descripcion;
  late String _categoria;
  late int _dificultad;
  late int _prioridad;
  late DateTime _fechaInicio;
  late DateTime _fechaFin;
  late String _imagen;
  late int _hecha;

  @override
  void initState() {
    super.initState();
    _titulo = widget.tarea.titulo;
    _descripcion = widget.tarea.descripcion;
    _categoria = widget.tarea.categoria;
    _dificultad = widget.tarea.dificultad;
    _prioridad = widget.tarea.prioridad;
    _fechaInicio = widget.tarea.fechaInicio;
    _fechaFin = widget.tarea.fechaFin;
    _imagen = widget.tarea.imagen;
    _hecha = widget.tarea.hecha;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              initialValue: _titulo,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un título';
                }
                return null;
              },
              onSaved: (value) {
                _titulo = value!;
              },
            ),
            TextFormField(
              initialValue: _descripcion,
              decoration: InputDecoration(labelText: 'Descripción'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onSaved: (value) {
                _descripcion = value!;
              },
            ),
            TextFormField(
              initialValue: _categoria,
              decoration: InputDecoration(labelText: 'Categoría'),
              onSaved: (value) {
                _categoria = value!;
              },
            ),
            TextFormField(
              initialValue: _dificultad.toString(),
              decoration: InputDecoration(labelText: 'Dificultad'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un valor para la dificultad';
                }
                final dificultad = int.tryParse(value);
                if (dificultad == null || dificultad < 1 || dificultad > 5) {
                  return 'Por favor ingrese un valor de 1 a 5 para la dificultad';
                }
                return null;
              },
              onSaved: (value) {
                _dificultad = int.parse(value!);
              },
            ),
            TextFormField(
              initialValue: _prioridad.toString(),
              decoration: InputDecoration(labelText: 'Prioridad'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un valor para la prioridad';
                }
                final prioridad = int.tryParse(value);
                if (prioridad == null || prioridad < 1 || prioridad > 5) {
                  return 'Por favor ingrese un valor de 1 a 5 para la prioridad';
                }
                return null;
              },
              onSaved: (value) {
                _prioridad = int.parse(value!);
              },
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Color rojo para el botón "Eliminar"
                  ),
                ),SizedBox(width: 16), // Agregamos un espacio en blanco
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Guardar la tarea actualizada
                      Tarea tareaActualizada = Tarea(
                        id: widget.tarea.id,
                        titulo: _titulo,
                        descripcion: _descripcion,
                        categoria: _categoria,
                        dificultad: _dificultad,
                        prioridad: _prioridad,
                        fechaInicio: _fechaInicio,
                        fechaFin: _fechaFin,
                        imagen: _imagen,
                        hecha: _hecha,
                      );
                      SQLHelper.editarTarea(tareaActualizada);
                    }
                  },
                  child: Text('Guardar'),
                ),
                          

                
  ],
),
          ],
        ),
      ),
    ),
  );
}


}