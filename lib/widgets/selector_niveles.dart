import 'package:flutter/material.dart';

class SelectorNiveles extends StatelessWidget {
  const SelectorNiveles({
    super.key,
    required this.valor,
  });

  final double valor;

  @override
  Widget build(BuildContext context) {
    final dificultad = valor == 0
        ? 'Fácil'
        : valor == 1
            ? 'Medio'
            : valor == 2
                ? 'Avanzado'
                : 'Extremo';

    return Column(
      children: [
        Text(dificultad),
        Slider(
          value: valor,
          min: 0,
          max: 3,
          divisions: 3,
          onChanged: (valorSeleccionado) {},
        ),
      ],
    );
  }
}
