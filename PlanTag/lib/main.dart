import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'pags/index.dart';

void main() /*async */ {
 // WidgetsFlutterBinding.ensureInitialized();
 // await SQLHelper.db();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlanTag App',
      theme: ThemeData(
        // This is the theme of your application.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    // Scaffold es como la página principal con la app bar que es la barra superior y el body
    return Index(widget: widget);
  }
}

