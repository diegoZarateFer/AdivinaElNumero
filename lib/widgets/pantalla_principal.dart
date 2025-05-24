import 'package:adivinaelnumero/widgets/contador_intentos.dart';
import 'package:adivinaelnumero/widgets/contenedor_numeros.dart';
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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        maxLength: 4,
                        decoration: InputDecoration(
                          label: Text('Numero'),
                          border: OutlineInputBorder(),
                          hintText: '####',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  ContadorIntentos(
                    intentosRestantes: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: ContenedorNumeros(
                      titulo: 'Mayor que',
                      numeros: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                    ),
                  ),
                  Expanded(
                    child: ContenedorNumeros(
                      titulo: 'Menor que',
                      numeros: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
