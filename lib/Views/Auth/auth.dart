import 'package:flutter/material.dart';
import 'package:waterapp/Components/Buttons/button.dart';
import 'package:waterapp/Components/Colors/colorBlue.dart';
import 'package:waterapp/Routes/routes.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Asegura que el fondo sea blanco
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Autenticación de Usuario',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: colorBlue)),
                const Text('Formulario de Login',
                    style: TextStyle(color: Colors.grey)),
                Image.asset('assets/images/startup.jpg'),
                Button(label: 'Login', press: () {
                  Navigator.pushNamed(context, RoutesApp.login);
                }),
                Button(label: 'Registro', press: () {
                  Navigator.pushNamed(context, RoutesApp.register);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

