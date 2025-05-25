import 'dart:math';

import 'package:adivinaelnumero/widgets/contador_intentos.dart';
import 'package:adivinaelnumero/widgets/contenedor_numeros.dart';
import 'package:adivinaelnumero/widgets/historial.dart';
import 'package:adivinaelnumero/widgets/selector_niveles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() {
    return _PantallaPrincipalState();
  }
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final _formKey = GlobalKey<FormState>();

  bool _cargandoHistorial = true;
  final TextEditingController _controladorNumero = TextEditingController();
  int _indiceNivelSeleccionado = 0;
  int _intentosRestantes = 5;
  int _numeroEscondido = Random().nextInt(10) + 1;
  List<int> _mayorQue = [], _menorQue = [], _historial = [];

  int _generarNumeroEscondido(int maxNumero) {
    return Random().nextInt(maxNumero) + 1;
  }

  int _obtenerIntervalo(int indiceDelNivel) {
    return indiceDelNivel == 0
        ? 10
        : indiceDelNivel == 1
            ? 20
            : indiceDelNivel == 2
                ? 100
                : 1000;
  }

  int _obtenerNumeroDeIntentos(int indiceDelNivel) {
    return indiceDelNivel == 0
        ? 5
        : indiceDelNivel == 1
            ? 8
            : indiceDelNivel == 2
                ? 15
                : 25;
  }

  String? _validarEntradaUsuario(String? cadenaIngresada) {
    if (cadenaIngresada == null) {
      return 'Campo vacio';
    }

    if (cadenaIngresada.trim().isEmpty) {
      return null;
    }

    var numeroIngresado = int.tryParse(cadenaIngresada);
    if (numeroIngresado == null) {
      return 'Debes ingresar un entero';
    }

    if (numeroIngresado <= 0) {
      return 'Debe ser mayor a 0';
    }

    int maxNumero = _obtenerIntervalo(_indiceNivelSeleccionado);
    if (numeroIngresado > maxNumero) {
      return 'Debe ser <= $maxNumero';
    }

    return null;
  }

  void _gestionarIntento() {
    if (_formKey.currentState!.validate() &&
        _controladorNumero.text.isNotEmpty) {
      _formKey.currentState!.save();

      //Gestionar intento del usuario.
      int numeroIngresado = int.parse(_controladorNumero.text.toString());
      if (numeroIngresado == _numeroEscondido) {
        // Se ha adivinado el número

        setState(() {
          _historial.add(_numeroEscondido);
        });
        _actualizarHistorial();

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡Has ganado!'),
          ),
        );

        _generarNuevoNivel(_indiceNivelSeleccionado);
      } else if (numeroIngresado > _numeroEscondido) {
        // El numero ingresado es mayor que el escondido
        setState(() {
          _menorQue.add(numeroIngresado);
          _intentosRestantes--;
        });
      } else {
        // El numero ingresado es menor que el escondido
        setState(() {
          _mayorQue.add(numeroIngresado);
          _intentosRestantes--;
        });
      }

      // Se terminan los intentos disponibles.
      if (_intentosRestantes == 0) {
        setState(() {
          _historial.add(-_numeroEscondido);
        });
        _actualizarHistorial();

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Se terminaron los intentos. Has perdido.'),
          ),
        );

        _generarNuevoNivel(_indiceNivelSeleccionado);
      }

      _controladorNumero.clear();
      FocusScope.of(context).unfocus();
    }
  }

  void _generarNuevoNivel(int nivelSeleccionado) {
    setState(() {
      _indiceNivelSeleccionado = nivelSeleccionado;
      _numeroEscondido =
          _generarNumeroEscondido(_obtenerIntervalo(nivelSeleccionado));
      _intentosRestantes = _obtenerNumeroDeIntentos(nivelSeleccionado);
      _mayorQue = [];
      _menorQue = [];
    });

    _controladorNumero.clear();
    _formKey.currentState!.validate();
  }

  Future<void> _cargarHistorial() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Extrayendo historial de shared preferences.
    final historialObtenido = prefs.getStringList('historial') ?? [];
    _historial = historialObtenido.map((s) => int.parse(s)).toList();
    setState(() {
      _cargandoHistorial = false;
    });
  }

  Future<void> _actualizarHistorial() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final historialAGuardar = _historial.map((x) => x.toString()).toList();
    prefs.setStringList('historial', historialAGuardar);
  }

  @override
  void initState() {
    super.initState();
    _cargarHistorial();
  }

  @override
  Widget build(BuildContext context) {
    return _cargandoHistorial
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                              onEditingComplete: _gestionarIntento,
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
                          intentosRestantes: _intentosRestantes,
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
                            numeros: _mayorQue,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: ContenedorNumeros(
                            titulo: 'Menor que',
                            numeros: _menorQue,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Historial(
                            juegos: _historial,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    SelectorNiveles(
                      valor: _indiceNivelSeleccionado.toDouble(),
                      cambiarDeNivel: _generarNuevoNivel,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
