import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/lista.dart';

class DetallesTarea extends StatelessWidget {
  final Lista tarea;

  DetallesTarea({required this.tarea});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tarea.titulo),
      ),
      body: Column(
        children: [
          Text(tarea.descripcion),
          Text(tarea.time.toString()),
        ],
      ),
    );
  }
}