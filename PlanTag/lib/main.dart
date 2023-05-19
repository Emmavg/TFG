import 'package:flutter/material.dart';
import 'pags/index.dart';

void main()  {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlanTag App',
      theme: ThemeData(
        // Con esta propiedad es con la única que funcionan los códigos de color de la api de material
        // Para cambiar las cosas referentes a la barra de arriba mejor en el método de abajo de appbar
        // primarySwatch: Colors.cyan,
        fontFamily: 'Schyler',
      ),
      home: const MyHomePage(
        title: 'PlanTag',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    // Scaffold es como la página principal con la app bar que es la barra superior y el body
    return Index(widget: widget);
  }
}
