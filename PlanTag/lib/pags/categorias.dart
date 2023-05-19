import 'package:flutter/material.dart';

import '../database_helper.dart';
import '../widgets/dialogo.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  List<String> _categorias = [];

  @override
  void initState() {
    super.initState();
    _fetchCategorias();
  }

  Future<void> _fetchCategorias() async {
    final categorias = await SQLHelper.categorias();
    setState(() {
      _categorias = categorias;
    });
  }

 void _mostrarDialogoCategoria() async {
  final result = await showDialog(
    context: context,
    builder: (BuildContext context) => DialogoCategoria(
      onClose: (result) {
        // Handle the result returned from the dialog here
        if (result != null) {
          _fetchCategorias();
        }
      },
    ),
  );

  // Handle the result returned from the dialog here
  if (result != null) {
    _fetchCategorias();
  }
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Custom logic to handle back button press
        // Return false to prevent leaving the page via the back button

        // Example: Go back to the previous page
        Navigator.pop(context);

        // Return false to prevent leaving the page via the back button
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Categorias",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'Trajan Pro',
            ),
          ),
          backgroundColor: const Color.fromRGBO(163, 238, 176, 1),
          toolbarHeight: 60,
          elevation: 5,
        ),
        body: ListView.builder(
          itemCount: _categorias.length,
          itemBuilder: (context, index) {
            final categoria = _categorias[index];
            return ListTile(
              leading: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await SQLHelper.eliminarCategoria(categoria);
                  _fetchCategorias();
                },
              ),
              title: Text(categoria),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _mostrarDialogoCategoria,
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
