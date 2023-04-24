// ********************************************************** CLASE DIALOGO **********************************************

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pags/logo.dart';

class Dialogo extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  // Para saber siempre el tamaño de la columna del formulario de forma dinámica aunque vaya cambiando por la panatalla
  final _keyTamColum = GlobalKey<FormState>();

  final _nomFld = TextEditingController();
  final _imgFld = TextEditingController();
  Dialogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Nueva categoría",
        textAlign: TextAlign.left,
      ),
      backgroundColor: Color.fromARGB(255, 223, 255, 222), // your color
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(40)), // change 40 to your desired radius
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
            key: _key,
            // Para que sea más responsive, si no entra en la pantalla le metemos un scroll view al diálogo que solo aparece cuando sea necesario de forma automática
            child: SingleChildScrollView(
              child: Column(
                // Para saber el tamaño de un componente en particular solamente le estableces su key y lo evaluamos al presionar el botón por ejemplo
                key: _keyTamColum,
                children: [
                  // ------------------------------------------- Logo --------------------------------------------
                  const LogoSettings(),

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

                  Row(
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          side: const BorderSide(
                              width: 2.0,
                              color: Color.fromARGB(255, 255, 9, 9)),
                          foregroundColor: const Color.fromARGB(255, 255, 9, 9),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          // Forma de cuadrado circular al botón
                          shape: const StadiumBorder(),
                          side: const BorderSide(
                              width: 2.0,
                              color: Color.fromARGB(255, 3, 223, 25)),
                          //backgroundColor: Color.fromARGB(255, 94, 255, 110),
                          // Color del texto
                          foregroundColor: const Color.fromARGB(255, 5, 177, 22),
                        ),
                        // --------------------------------- Metodo pulsar btn --------------------------------------
                        onPressed: () {
                          // Depende de si está definido el contexto o no y de si está o no asignada la key a este componente por lo que arriba lo evaluamos con una condicion
                          // y ponemos la ! para decirle a flutter que nos aseguramos que recibe esa variable

                          print(_key.currentContext!.size);
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