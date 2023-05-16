import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';
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
  late int _dificultad = 3;
  late String _imagen;
  late int _prioridad =3;
  late DateTime _fechaInicio = DateTime.now();
  late DateTime _fechaFin = DateTime.now();
  List<String> _categorias = ['Categoria 1', 'Categoria 2', 'Categoria 3']; // esto hay que sustituir por una funcion que nos devuelva de la base las distintas categorias
  List<String> _imagenes = ['Tulipan', 'Rosa', 'Petunia'];  // esto igual con los nombres de las plantas
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
  void initState() {
    super.initState();
    _categoria = _categorias[0];
    _imagen = _imagenes[0];
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "Nueva tarea",
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontFamily: 'Trajan Pro'),
            ),

          ],
        ),
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
            DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Categoria'),
                value: _categoria,
                items: _categorias.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione una categoria';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _categoria = value!;
                  });
                },
              ),
              
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Planta'),
                value: _imagen,
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
                    _imagen = value!;
                  });
                },
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Dificultad',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Theme(
              data: ThemeData(
                  sliderTheme: SliderThemeData(
                  activeTrackColor: Color.fromARGB(255, 82, 189, 100), // Set the color of the active track
                  thumbColor: Color.fromARGB(255, 82, 189, 100), // Color of the thumb

                ),
              ),
              child: Slider(
                value: _dificultad.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (newValue) {
                  setState(() {
                    _dificultad = newValue.toInt();
                  });
                },
                label: _dificultad.toString(),
              ),
            ),
            Text(
              'Prioridad',
              style: TextStyle(fontSize: 16),
            ),
            Theme(
              data: ThemeData(
                  sliderTheme: SliderThemeData(
                  activeTrackColor: Color.fromARGB(255, 82, 189, 100), // Set the color of the active track
                  thumbColor: Color.fromARGB(255, 82, 189, 100), // Color of the thumb

                ),
              ),
              child: Slider(
              value: _prioridad.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (newValue) {
                setState(() {
                  _prioridad = newValue.toInt();
                });
              },
              label: _prioridad.toString(),
            )),
           
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final tarea = Tarea(
                    id: null,
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
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ),
                    );

                }
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 82, 189, 100),
            ),
            child: Text('Plantar'),
            
          ),
        ],
      ),),),
    );
}}