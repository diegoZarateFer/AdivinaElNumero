import 'package:adivinaelnumero/widgets/contador_intentos.dart';
import 'package:adivinaelnumero/widgets/contenedor_numeros.dart';
import 'package:adivinaelnumero/widgets/historial.dart';
import 'package:adivinaelnumero/widgets/selector_niveles.dart';
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

  final TextEditingController _controladorNumero = TextEditingController();

  String? _validarEntradaUsuario(String? cadenaIngresada) {
    //TODO: validar rangos de acuerdo al nivel seleccionado.
    if (cadenaIngresada == null || cadenaIngresada.trim().isEmpty) {
      return 'Ingresa un número';
    }

    var numeroIngresado = int.tryParse(cadenaIngresada);
    if (numeroIngresado == null) {
      return 'Debes ingresar un entero';
    }

    if (numeroIngresado <= 0) {
      return 'Debe ser mayor a 0';
    }

    return null;
  }

  void _gestionarAdivinanza() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

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
                        keyboardType: TextInputType.numberWithOptions(),
                        maxLength: 4,
                        controller: _controladorNumero,
                        validator: _validarEntradaUsuario,
                        onEditingComplete: _gestionarAdivinanza,
                        decoration: InputDecoration(
                          label: Text('Numero'),
                          border: OutlineInputBorder(),
                          hintText: '####',
                          counterText: "",
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
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ContenedorNumeros(
                      titulo: 'Menor que',
                      numeros: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Historial(
                      juegos: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              SelectorNiveles(
                valor: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
