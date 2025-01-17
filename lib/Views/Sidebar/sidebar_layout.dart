import 'package:flutter/material.dart';
import 'package:waterapp/Repositories/TokenRepository/TokenRepository.dart';
import 'package:waterapp/Views/Administrative/administrative_panel.dart';
import 'package:waterapp/Views/Sidebar/Sidebar.dart';

class SidebarLayout extends StatefulWidget {
  const SidebarLayout({super.key});

  @override
  _SidebarLayoutState createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> {
  bool isSidebarOpen = false;
  final TokenRepository _tokenRepository = TokenRepository();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final loggedIn = await _tokenRepository.isLoggedIn();
    if (loggedIn) {
      setState(() {
        isSidebarOpen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AdministrativePanel(),
          SideBar(),
        ],
      ),
    );
  }
}