import 'package:flutter/material.dart';

class Historial extends StatelessWidget {
  const Historial({
    super.key,
    required this.juegos,
  });

  final List<int> juegos;

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
            'Historial',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: juegos.length,
              itemBuilder: (ctx, index) {
                return Center(
                  child: Text(
                    '${juegos[index]}',
                    style: TextStyle(
                      fontSize: 18,
                      color: juegos[index] < 0 ? Colors.red : Colors.green,
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
