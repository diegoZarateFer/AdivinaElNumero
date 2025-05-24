import 'package:flutter/material.dart';

class ContadorIntentos extends StatelessWidget {
  const ContadorIntentos({
    super.key,
    required this.intentosRestantes,
  });

  final int intentosRestantes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Intentos'),
        const SizedBox(
          height: 4,
        ),
        Text('$intentosRestantes'),
      ],
    );
  }
}
