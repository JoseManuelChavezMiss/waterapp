import 'package:flutter/material.dart';
import 'package:waterapp/Components/Buttons/button.dart';
import 'package:waterapp/Components/Colors/colorBlue.dart';
import 'package:waterapp/Components/Text/textfield.dart';
import 'package:waterapp/Models/AuthModels/JwtDTO.dart';
import 'package:waterapp/Repositories/AuthRepository/AuthRepository.dart';
import 'package:waterapp/Repositories/TokenRepository/TokenRepository.dart';
import 'package:waterapp/Routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterapp/Views/Sidebar/Sidebar_layout.dart';

import '../../Models/AuthModels/loginUser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();

  Future<void> _handleLogin() async {
    final username = userNameController.text;
    final password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      final user = LoginUser(nombreUsuario: username, password: password);
      final response = await _authRepository.loginUser(user);

      if (response != null && response.containsKey('token')) {
        final jwt = JwtDTO.fromJson(response);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', jwt.token);
        final rolUser = TokenRepository().getDecodedToken(jwt.token);

        switch (rolUser) {
          case 'ROLE_ADMIN':
            // Navigator.pushNamed(context, RoutesApp.admin);
            Fluttertoast.showToast(
                msg: "Bienvenido administrador",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
                webPosition: "right");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SidebarLayout()),
            );
            break;
          case 'ROLE_REPARTIDOR':
            Fluttertoast.showToast(
                msg: "Bienvenido repartidor",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
                webPosition: "right");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SidebarLayout()),
            );

            break;
          default:
            print('Rol no encontrado');
        }
      } else {
        // Maneja el error de autenticación
        print('Error en la autenticación');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white, // Color uniforme de fondo
          height: MediaQuery.of(context)
              .size
              .height, // Asegura que ocupe toda la pantalla
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context)
                    .size
                    .height, // Altura mínima igual a la pantalla
              ),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 40.0), // Padding alrededor del contenido
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'INICIO DE SESIÓN',
                        style: TextStyle(
                          color: colorBlue,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20), // Espacio entre widgets
                      Flexible(
                        child: Image.asset(
                          'assets/images/background.jpg',
                          fit:
                              BoxFit.contain, // Escala la imagen sin deformarla
                        ),
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        hint: 'Correo/usuario',
                        icon: Icons.account_circle,
                        controller: userNameController,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        hint: 'Password',
                        icon: Icons.lock,
                        controller: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      Button(label: 'Login', press: _handleLogin),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿No tienes cuenta?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RoutesApp.register);
                            },
                            child: const Text(
                              'Regístrate',
                              style: TextStyle(
                                color: colorBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:waterapp/Components/Buttons/button.dart';
// import 'package:waterapp/Components/Colors/colorBlue.dart';
// import 'package:waterapp/Components/Text/textfield.dart';
// import 'package:waterapp/Routes/routes.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final userName = TextEditingController();
//   final password = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             color: Colors.white, // Asegura que el fondo sea blanco
//             padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0), // Añade padding
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text('INICIO DE SESIÓN', style: TextStyle(color: colorBlue, fontSize: 35, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 20), // Añade espacio entre los widgets
//                 Image.asset('assets/images/background.jpg', height: 200, width: 200), // Establece un tamaño fijo para la imagen
//                 const SizedBox(height: 20), // Añade espacio entre los widgets
//                 InputField(hint: 'Correo/usuario', icon: Icons.account_circle, controller: userName),
//                 const SizedBox(height: 20), // Añade espacio entre los widgets
//                 InputField(hint: 'Password', icon: Icons.lock, controller: password, isPassword: true),
//                 const SizedBox(height: 20), // Añade espacio entre los widgets
//                 Button(label: 'Login', press: (){}),
//                 const SizedBox(height: 20), // Añade espacio entre los widgets
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text('¿No tienes cuenta?', style: TextStyle(color: Colors.grey)),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, RoutesApp.register);
//                       },
//                       child: const Text('Regístrate', style: TextStyle(color: colorBlue, fontWeight: FontWeight.bold)),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:waterapp/Components/Buttons/button.dart';
// import 'package:waterapp/Components/Colors/colorBlue.dart';
// import 'package:waterapp/Components/Text/textfield.dart';
// import 'package:waterapp/Routes/routes.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {

//   final userName = TextEditingController();
//   final password = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white, // Asegura que el fondo sea blanco
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('INICIO DE SESIÓN', style: TextStyle(color: colorBlue, fontSize: 35, fontWeight: FontWeight.bold)),
//             Image.asset('assets/images/background.jpg'),
//             InputField(hint: 'Correo/usuario', icon: Icons.account_circle, controller: userName),
//             InputField(hint: 'Password', icon: Icons.lock, controller: password, isPassword: true),
//             Button(label: 'Login', press: (){}),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('¿No tienes cuenta?', style: TextStyle(color: Colors.grey)),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, RoutesApp.register);
//                   },
//                   child: const Text('Regístrate', style: TextStyle(color: colorBlue, fontWeight: FontWeight.bold)),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:waterapp/Components/Colors/colorBlue.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Añade tus widgets aquí
//           const Text('INICIO DE SESIÓN', style: TextStyle(color: colorBlue, fontSize: 35, fontWeight: FontWeight.bold)),
//           Image.asset('assets/images/background.jpg'),
//         ],
//       ),
//     );
//   }
// }
