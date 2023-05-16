import 'package:flutter/material.dart';

import '../database_helper.dart';
import '../widgets/dialogo.dart';

class CategoriasPage extends StatefulWidget {
  @override
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



  void _mostrarDialogoCategoria() {
     showDialog(
                  context: context,
                  builder: (BuildContext context) => DialogoCategoria(
                  
                  ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
              title: Text(
                "Categorias",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Trajan Pro',
                ),
              ),
        backgroundColor: Color.fromRGBO(163, 238, 176, 1),
        toolbarHeight: 60,
        elevation: 5,
      ),
      body: ListView.builder(
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          final categoria = _categorias[index];
          return ListTile(
            leading: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => {
                SQLHelper.eliminarCategoria(categoria),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  CategoriasPage()),
                  )
              }
            ),
            title: Text(categoria),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoCategoria,
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
    );
  }
}