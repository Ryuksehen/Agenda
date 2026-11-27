import 'package:flutter/material.dart';

/// Placeholder del Tech Lead (fase 1).
/// Este archivo es de Alejandro (Rol 5): en la fase 3 lo reemplaza
/// por la versión con BlocProvider, get_it e initializeDateFormatting.
void main() {
  runApp(const GestorAgendaApp());
}

class GestorAgendaApp extends StatelessWidget {
  const GestorAgendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gestor de Agenda',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text('Gestor de Agenda · en construcción')),
      ),
    );
  }
}
