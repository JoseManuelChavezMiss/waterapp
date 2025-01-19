import 'package:flutter/material.dart';

class DeliveryHome extends StatelessWidget {
  const DeliveryHome ({super.key});

  @override
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPARTIDOR'),
      ),
      body: Center(
        child: Text(
          'Panel REPARTIDOR',
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