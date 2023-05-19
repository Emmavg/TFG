// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tarea.dart';
import 'package:plantag/database_helper.dart';

class NuevaTarea extends StatefulWidget {
  const NuevaTarea({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NuevaTareaState createState() => _NuevaTareaState();
}

class _NuevaTareaState extends State<NuevaTarea> {
  final _formKey = GlobalKey<FormState>();
  late String _titulo;
  late String _descripcion;
  late String _categoria;
  late int _dificultad = 3;
  late String _imagen;
  late int _prioridad = 3;
  late DateTime _fechaInicio = DateTime.now();
  late DateTime _fechaFin = DateTime.now();
  List<String> _categorias = []; // Initialize as an empty list
  final List<String> _imagenes = ['Tulipan', 'Rosa', 'Margarita', 'Hibisco'];

  Future<List<String>> _fetchCategorias() async {
    List<String> categorias =  await SQLHelper.categorias();
    if(categorias.length ==0){
      SQLHelper.insertarCategoria("Otros");
      categorias.add("Otros");
    }
    return categorias;
  }

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
    _fetchCategorias().then((categorias) {
      setState(() {
        _categorias = categorias;
        _categoria = _categorias[0];
      });
    });
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
        toolbarHeight: 60,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Titulo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un titulo';
                  }
                  return null;
                },
                onSaved: (value) => _titulo = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText
              : 'Descripcion'),
              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una descripcion';
              }
                return null;
              },
              onSaved: (value) => _descripcion = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fecha inicio'),
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
                decoration: const InputDecoration(labelText: 'Fecha fin'),
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
              FutureBuilder<List<String>>(
              future: _fetchCategorias(),
              builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                _categorias = snapshot.data!;
                return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Categoria'),
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
              );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
              return const Text('No data available');
              }
              },
              ),
              DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Planta'),
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
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                'Dificultad',
                style: TextStyle(fontSize: 16),
                ),
              ),
              Theme(
                data: ThemeData(
                sliderTheme: const SliderThemeData(
                activeTrackColor: Color.fromARGB(255, 82, 189, 100),
                thumbColor: Color.fromARGB(255, 82, 189, 100),
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
              const Text(
              'Prioridad',
              style: TextStyle(fontSize: 16),
              ),
              Theme

              (
              data: ThemeData(
              sliderTheme: const SliderThemeData(
                activeTrackColor: Color.fromARGB(255, 82, 189, 100),
                thumbColor: Color.fromARGB(255, 82, 189, 100),
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
              ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final tarea = Tarea(
                      id: null,
                      titulo: _titulo,
                      descripcion: _descripcion,
                      fechaInicio: _fechaInicio,
                      fechaFin: _fechaFin,
                      categoria: _categoria,
                      dificultad: _dificultad,
                      imagen: _imagen,
                      prioridad: _prioridad,
                      hecha: 0,
                    );
                    SQLHelper.insertarTarea(tarea).then((_) {
                      Navigator.pop(context, true); // Pass true back to the previous screen
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 82, 189, 100),
                ),
                child: const Text('Plantar'),
              ),

            ],
         ),
     ),
    ),
  );
}
}