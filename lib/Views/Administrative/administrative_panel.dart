import 'package:flutter/material.dart';

class AdministrativePanel extends StatelessWidget {
  const AdministrativePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrative Panel'),
      ),
      body: Center(
        child: Text(
          'Panel Administrativo',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}