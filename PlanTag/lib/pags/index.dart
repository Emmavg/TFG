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
      // --------------------------------------------------- Barra superior ---------------------------------------------
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Le ponemos el título asignado arriba en el widget + "app"
            Text(
              widget.widget.title,
              style: const TextStyle(
                  fontSize: 20, color: Colors.white, fontFamily: 'Trajan Pro'),
            ),
            const Text(
              'App',
              style: TextStyle(
                  fontSize: 20, color: Colors.grey, fontFamily: 'Trajan Pro'),
            ),
          ],
        ),

        // -------------------------------------------- ELEMENTOS QUE TIENEN ACCIONES ---------------------------------------
        actions: [
          Row(
            children: [

              // ------------------------------ Lista desplegable seleccionar que tiene un filtro -------------------------
              DropdownButton(
                  items: <String>["Por fecha", "Por creación"]
                      .map((i) => DropdownMenuItem<String>(
                          value: i,
                          child: Text(i,
                              style:
                                  const TextStyle(color: Colors.deepOrange))))
                      .toList(),
                  // Le colocamos texto inicial al menú deslegable, si la propiedad orderselected es "" entonces le ponemos el txt de la const
                  hint: _orderSelected == ""
                      ? const Text(
                          "Seleccionar", style: TextStyle(color: Colors.black),

                          // Sino
                        )
                      : Text(_orderSelected,
                          style: const TextStyle(color: Colors.black)),
                  
                  // --------------------------------------- ACCION CUANDO SE SELECCIONE UN VALOR --------------------------
                  onChanged: (value) {
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
                // Verde menta
                color: const Color.fromARGB(255, 203, 255, 202),
                child: SfDateRangePicker(
                  monthViewSettings:
                      const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  // Seleccion por rango
                  startRangeSelectionColor: Colors.purple,
                  endRangeSelectionColor: Colors.purple,
                  rangeSelectionColor: Colors.yellow,
                  selectionColor: Colors.black,
                  selectionMode: DateRangePickerSelectionMode.range,

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
                  onSubmit: (DateRange) {
                    print(DateRange);
                  },

                  // Cuando cambiamos la fecha seleccionada
                  onSelectionChanged: (DateRange) {
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

class _LogoSettings extends StatelessWidget {
  const _LogoSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Le ponemos que tenga detección de gestos para que le podamos hacer click y definimos el método onTap debajo:
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child:
            CircleAvatar(backgroundImage: AssetImage("assets/images/logo.jpg")),
      ),

      // ------------------------------------- Metodo cuando pulsas el logo muestra dialogo  ---------------------------------
      onTap: () {
        showCupertinoDialog(
            // El barrier es para especificar que cuando toque otra zona de la pantalla se cierra
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return _Dialogo();
            });
      },
    );
  }
}

// ********************************************************** CLASE DIALOGO **********************************************

class _Dialogo extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  // Para saber siempre el tamaño de la columna del formulario de forma dinámica aunque vaya cambiando por la panatalla
  final _keyTamColum = GlobalKey<FormState>();

  final _nomFld = TextEditingController();
  final _imgFld = TextEditingController();
  _Dialogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nueva categoría", textAlign: TextAlign.left,),
      backgroundColor: Color.fromARGB(255, 223, 255, 222), // your color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),// change 40 to your desired radius
      // ------------------------------------------- CONSTRAINT LAYOUT  -------------------------------------------
      // Dependiendo de la pantalla, especificamos los tamaños estandar
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 800,
          minHeight: 200,
          maxHeight: 300,
        ),
        child: SizedBox(
          // Sacamos la altura y anchura del padre o de la ventana principal en este caso y le decimos que queremos ocupar un 40% de la misma
          width: MediaQuery.of(context).size.width * .4,
          height: MediaQuery.of(context).size.height * .4,
          
          // ----------------------------------------- FORMULARIO DEL DIALOGO ------------------------------------
          
          child: Form(
            // Le decimos a flutter que efectivamente le asignamos esta key al componente Form para poderlo evaluar abajo en el método de presionar el botón
            key:_key,
            // Para que sea más responsive, si no entra en la pantalla le metemos un scroll view al diálogo que solo aparece cuando sea necesario de forma automática
            child: SingleChildScrollView(
              child: Column(
                // Para saber el tamaño de un componente en particular solamente le estableces su key y lo evaluamos al presionar el botón por ejemplo
                key: _keyTamColum,
                children: [
                  // ------------------------------------------- Logo --------------------------------------------
                  const _LogoSettings(),
            
                  // -------------------------------------- TxtFld Nombre ----------------------------------------
                  TextFormField(
                    controller: _nomFld,
                    decoration: const InputDecoration(
                    labelText: "Nombre", border: OutlineInputBorder()),

                    // Validamos si es correcto ese campo o si está relleno en caso de ser obligatorio (Cuando se pulsa el botón abajo se valida)
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor introduce algo';
                      }
                      return null;
                    },
                  ),
            
                  // Le añadimos un espacio para que no estén tan pegados como si fuera un br
                  const SizedBox(height: 10),
                  
                  // ---------------------------------------- TxtFld Img ----------------------------------------
                  TextFormField(
                    controller: _imgFld,
                    decoration: const InputDecoration(
                    labelText: "Imagen", border: OutlineInputBorder()),
                  ),
            
                  // Le añadimos un espacio para que no estén tan pegados como si fuera un br
                  const SizedBox(height: 35),
            
                  // -------------------------------------- Btns Formulario ----------------------------------------
                    
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [

                      // ---------------------------------------- Btn Cancel --------------------------------------
                      OutlinedButton.icon(
                        icon: const Icon(Icons.close),
                        label: const Text("Cancelar"),
                        onPressed: () {
                          // Cerramos la ventana cuando pulsemos el botón
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          side: const BorderSide(width: 2.0, color:Color.fromARGB(255, 255, 9, 9)),
                          foregroundColor: Color.fromARGB(255, 255, 9, 9),
                          // Forma de cuadrado circular al botón
                          shape: const StadiumBorder(),
                        ),
                      ),

                      // Le añadimos un espacio para que no estén tan pegados como si fuera un br
                      const SizedBox(width: 30),


                      // ---------------------------------------- Btn Ok --------------------------------------
                      OutlinedButton.icon(
                        icon: const Icon(Icons.done),
                        label: const Text("Aceptar"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          // Forma de cuadrado circular al botón
                          shape: const StadiumBorder(),
                          side: const BorderSide(width: 2.0, color:Color.fromARGB(255, 3, 223, 25)),
                          //backgroundColor: Color.fromARGB(255, 94, 255, 110),
                          // Color del texto
                          foregroundColor: Color.fromARGB(255, 5, 177, 22),
                        ),
                        // --------------------------------- Metodo pulsar btn --------------------------------------
                        onPressed: () {
                          // Depende de si está definido el contexto o no y de si está o no asignada la key a este componente por lo que arriba lo evaluamos con una condicion
                          // y ponemos la ! para decirle a flutter que nos aseguramos que recibe esa variable
                        
                          print( _key.currentContext!.size);
                          // Validamos si es correcto el formulario y están todos los campos rellenos o falta alguno obligatorio
                          if (_key.currentState!.validate()) {
                            // Process data.
                            // Cerramos la ventana cuando pulsemos el botón
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  )
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
