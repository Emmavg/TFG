import 'package:flutter/material.dart';
import 'package:plantag/database_helper.dart';
import 'package:plantag/pags/categorias.dart';
import 'package:plantag/widgets/logo.dart';

class DialogoCategoria extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final _keyTamColum = GlobalKey<FormState>();
  final _nomFld = TextEditingController();
  final Function(dynamic) onClose;

  DialogoCategoria({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoriasPage()),
        );
        return false;
      },
      child: AlertDialog(
        title: const Text(
          "Nueva categoría",
          textAlign: TextAlign.left,
        ),
        backgroundColor: const Color.fromARGB(255, 223, 255, 222),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 100,
            maxWidth: 1000,
            minHeight: 200,
            maxHeight: 200,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            height: MediaQuery.of(context).size.height * .4,
            child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  key: _keyTamColum,
                  children: [
                    const LogoSettings(),
                    TextFormField(
                      controller: _nomFld,
                      decoration: const InputDecoration(
                        labelText: "Nombre",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor introduce algo';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0, left: 2),
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.close),
                            label: const Text("Cancelar"),
                            onPressed: () {
                              Navigator.pop(context);
                              onClose(null); // Pass null to the onClose callback
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              side: const BorderSide(
                                  width: 2.0,
                                  color: Color.fromARGB(255, 255, 9, 9)),
                              foregroundColor:
                                  const Color.fromARGB(255, 255, 9, 9),
                              shape: const StadiumBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0, right: 10),
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.done),
                            label: const Text("Aceptar"),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              shape: const StadiumBorder(),
                              side: const BorderSide(
                                  width: 2.0,
                                  color: Color.fromARGB(255, 3, 223, 25)),
                              foregroundColor:
                                  const Color.fromARGB(255, 5, 177, 22),
                            ),
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                SQLHelper.insertarCategoria(_nomFld.text);
                                Navigator.pop(context);
                                onClose(true); // Pass the result to the onClose callback
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
