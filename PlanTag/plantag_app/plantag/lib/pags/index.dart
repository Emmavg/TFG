import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../main.dart';

class Index extends StatefulWidget {
  const Index({
    super.key,
    required this.widget,
  });

  final MyHomePage widget;

  // Con el ctrl + . encima del statefull lo hemos podido convertir a stateful widget para que los objetos puedan realizar acciones
  // En este caso la lista desplegable de la barra de nav
  @override
  State<Index> createState() => _IndexState();
}


// ********************************************************** CLASE PRINCIPAL **********************************************

class _IndexState extends State<Index> {

// Creamos la propiedad para que el valor del dropdown item cambie cuando se selecciona
  String _orderSelected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Le ponemos el título asignado arriba en el widget
              Text(widget.widget.title, style: const TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Trajan Pro'),),
              Text('App', style: const TextStyle(fontSize: 20, color: Colors.grey, fontFamily: 'Trajan Pro'),),
            ],
          ),
          actions: [
            Row(
              children: [
                DropdownButton(items: <String>["Por fecha", "Por creación"].map((i) => DropdownMenuItem<String>(value: i, child: Text(i, style: const TextStyle(color: Colors.deepOrange)))).toList(), 
                // Le colocamos texto inicial al menú deslegable, si la propiedad orderselected es "" entonces le ponemos el txt de la const
                hint: _orderSelected == "" ? const Text("Seleccionar", style: TextStyle(color: Colors.black),

                // Sino
                ): Text(_orderSelected, style: const TextStyle(color: Colors.black)),
                onChanged: (value){
                  setState(() {
                     _orderSelected = value.toString(); 
                  });
                }),

                // ---------------------------------------- Colocamos un logo al lado del desplegable -------------------
                const _LogoSettings(),
              ],
            )
          ], 
       
        backgroundColor: const Color.fromARGB(255, 78, 241, 190),
        toolbarHeight: 60,
        // Le añadimos sombra a la parte de debajo de la barra
        elevation: 5,
      ),

      // ----------------------------------------------------- BODY ------------------------------------------------------
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Parte del calendario
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 185, 249, 243),
                child: SfDateRangePicker(
                  // Seleccion por rango
                  startRangeSelectionColor: Colors.purple,
                  endRangeSelectionColor: Colors.purple,
                  rangeSelectionColor: Colors.yellow,
                  selectionColor: Colors.black,
                  selectionMode:  DateRangePickerSelectionMode.range,

                  // Ponemos un rango por defecto
                  initialSelectedRange: PickerDateRange(

                    // Desde hace 3 días hasta después de 7 días
                    DateTime.now().subtract(const Duration(days: 3)),
                    DateTime.now().add(const Duration(days: 7)),
                  ),

                  // Mostramos los botones de acción
                  showActionButtons: true,
                  confirmText: "Plantar",
                  cancelText: "Cancelar",

                  // Cuando aceptas el rango seleccionado
                  onSubmit: (DateRange){
                    print(DateRange);
                  },

                  // Cuando cambiamos la fecha seleccionada
                  onSelectionChanged: (DateRange){
                    print(DateRange.value);
                  },
                ),
              ),
              )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// ********************************************************** CLASE LOGO **********************************************


class _LogoSettings extends StatelessWidget{
  const _LogoSettings ({Key? key}) : super (key:key);

  @override
  Widget build (BuildContext context){

    // Le ponemos que tenga detección de gestos para que le podamos hacer click y definimos el método onTap debajo:
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: CircleAvatar(backgroundImage: AssetImage("assets/images/logo.jpg")),
      ),
      onTap: (){
        showCupertinoDialog(
          context: context, 
          builder: (context) {
          return const _Dialogo();
        } );
      },
    );
  }
} 

// ********************************************************** CLASE DIALOGO **********************************************

class _Dialogo extends StatelessWidget{
  const _Dialogo ({Key? key}) : super (key:key);

  @override
  Widget build (BuildContext context){

    return CupertinoAlertDialog(
      content: Container(
        
        child: Text("Hola"),
        // Sacamos la altura y anchura del padre o de la ventana principal en este caso y le decimos que queremos ocupar un 40% de la misma  
        width: MediaQuery.of(context).size.width* .4,
        height: MediaQuery.of(context).size.height* .4,
      ),
    );
  }
} 