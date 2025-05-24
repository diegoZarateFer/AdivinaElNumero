import 'package:flutter/material.dart';

class ContenedorNumeros extends StatelessWidget {
  const ContenedorNumeros({
    super.key,
    required this.numeros,
  });

  final List<int> numeros;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: ListView.builder(
        itemCount: numeros.length,
        itemBuilder: (ctx, index) {
          return Center(
            child: Text(
              '${numeros[index]}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
      ),
    );
  }
}
