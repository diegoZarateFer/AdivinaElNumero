import 'package:adivinaelnumero/widgets/pantalla_principal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final esquemaColor = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 20, 20, 20),
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 38, 38, 38),
  colorScheme: esquemaColor,
  appBarTheme: AppBarTheme(
    color: const Color.fromARGB(255, 45, 45, 45),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
    ),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: PantallaPrincipal(),
    );
  }
}
