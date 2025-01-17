import 'package:flutter/material.dart';
import 'package:waterapp/Views/Administrative/administrative_panel.dart';
import 'package:waterapp/Views/Auth/login.dart';
import 'package:waterapp/Views/Auth/register.dart';

class RoutesApp {
  // static const String auth = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String administrative = '/administrative';

  static Map<String, WidgetBuilder> routes = {
    // auth: (context) => const AuthScreen(),
    login: (context) => const Login(),
    register: (context) => const Register(),
    administrative: (context) => const AdministrativePanel(),
  };
}