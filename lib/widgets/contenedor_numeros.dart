import 'package:flutter/material.dart';

class ContenedorNumeros extends StatelessWidget {
  const ContenedorNumeros({
    super.key,
    required this.numeros,
    required this.titulo,
  });

  final String titulo;
  final List<int> numeros;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}
