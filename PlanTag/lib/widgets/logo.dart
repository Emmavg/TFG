// ********************************************************** CLASE LOGO **********************************************

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantag/widgets/dialogo.dart';

class LogoSettings extends StatelessWidget {
  const LogoSettings({Key? key}) : super(key: key);

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
      // onTap: () {
      //   showCupertinoDialog(
      //       // El barrier es para especificar que cuando toque otra zona de la pantalla se cierra
      //       barrierDismissible: false,
      //       context: context,
      //       builder: (context) {
      //         return Dialogo();
      //       });
      // },
    );
  }
}