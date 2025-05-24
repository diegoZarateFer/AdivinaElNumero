import 'package:adivinaelnumero/widgets/contador_intentos.dart';
import 'package:flutter/material.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() {
    return _PantallaPrincipalState();
  }
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adivina el Número'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('Numeros'),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ContadorIntentos(
                intentosRestantes: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
