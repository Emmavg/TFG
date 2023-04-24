import 'package:flutter/material.dart';

// ------------------------------------- Clase para la lista-------------------------------------------------//
class VistaLista2 extends StatelessWidget {
  const VistaLista2({super.key});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Expanded(

          // -------------- El lado izquierdo es más grande que el derecho con el valor del flex -----------------
          flex: 4,
          child: Container(
            color: Colors.amber,
            
          )
        ),
        Expanded(
          flex: 2,
          child: Container(color: Colors.black,) 
        ),
      ],
    );
  }
  
}
