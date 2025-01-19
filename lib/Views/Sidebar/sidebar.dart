import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:waterapp/Components/Colors/colorBlue.dart';
import 'package:waterapp/Views/Sidebar/menu_item.dart';

class SideBar extends StatefulWidget {
  final String? userRole;

  const SideBar({Key? key, this.userRole}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenStreamController;
  late Stream<bool> isSidebarOpenStream;
  late StreamSink<bool> isSidebarOpenSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenStreamController = PublishSubject<bool>();
    isSidebarOpenStream = isSidebarOpenStreamController.stream;
    isSidebarOpenSink = isSidebarOpenStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenStreamController.close();
    isSidebarOpenSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenStream,
      builder: (context, isSidebarOpendAsyncs) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSidebarOpendAsyncs.data! ? 0 : -screenWidth,
          right: isSidebarOpendAsyncs.data! ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: colorSidebar,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 100),
                      ListTile(
                        title: Text(
                          "José",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "jose47@gmail.com",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      if (widget.userRole == 'ROLE_ADMIN') ...[
                        MenuItem(
                          icon: Icons.settings,
                          title: "Panel Administrativo",
                        ),
                        MenuItem(
                          icon: Icons.location_on,
                          title: "Tracking",
                        ),
                      ],
                      MenuItem(
                        icon: Icons.home,
                        title: "Inicio",
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: Container(
                    width: 35,
                    height: 110,
                    color: colorSidebar,
                    alignment: Alignment.centerLeft,
                    child: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _animationController.view,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:waterapp/Components/Colors/colorBlue.dart';
// import 'package:waterapp/Views/Sidebar/menu_item.dart';

// class SideBar extends StatefulWidget {
//   @override
//   _SideBarState createState() => _SideBarState();
// }

// class _SideBarState extends State<SideBar>
//     with SingleTickerProviderStateMixin<SideBar> {
//   late AnimationController _animationController;
//   late StreamController<bool> isSidebarOpenStreamController;
//   late Stream<bool> isSidebarOpenStream;
//   late StreamSink<bool> isSidebarOpenSink;
//   final _animationDuration = const Duration(milliseconds: 500);

//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: _animationDuration);
//     isSidebarOpenStreamController = PublishSubject<bool>();
//     isSidebarOpenStream = isSidebarOpenStreamController.stream;
//     isSidebarOpenSink = isSidebarOpenStreamController.sink;
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     isSidebarOpenStreamController.close();
//     isSidebarOpenSink.close();
//     super.dispose();
//   }

//   void onIconPressed() {
//     final animationStatus = _animationController.status;
//     final isAnimationCompleted = animationStatus == AnimationStatus.completed;

//     if (isAnimationCompleted) {
//       isSidebarOpenSink.add(false);
//       _animationController.reverse();
//     } else {
//       isSidebarOpenSink.add(true);
//       _animationController.forward();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return StreamBuilder<bool>(
//       initialData: false,
//       stream: isSidebarOpenStream,
//       builder: (context, isSidebarOpendAsyncs) {
//         return AnimatedPositioned(
//           duration: _animationDuration,
//           top: 0,
//           bottom: 0,
//           left: isSidebarOpendAsyncs.data! ? 0 : -screenWidth,
//           right: isSidebarOpendAsyncs.data! ? 0 : screenWidth - 45,
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: Container(
//                     color: colorSidebar,
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           height: 100,
//                         ),
//                         ListTile(
//                           title: Text(
//                             "José",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.w800),
//                           ),
//                           subtitle: Text(
//                             "jose47@gmail.com",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                           leading: CircleAvatar(
//                             child: Icon(
//                               Icons.perm_identity,
//                               color: Colors.white,
//                             ),
//                             radius: 40,
//                           ),
//                         ),
//                         Divider(
//                           height: 64,
//                           thickness: 0.5,
//                           color: Colors.white.withOpacity(0.3),
//                           indent: 32,
//                           endIndent: 32,
//                         ),
//                         MenuItem(
//                           icon: Icons.settings,
//                           title: "Panel Administrativo",
//                         ),
//                         MenuItem(
//                           icon: Icons.location_on,
//                           title: "Tracking",
//                         ),
//                         MenuItem(
//                           icon: Icons.home,
//                           title: "Inicio",
//                         ),
//                       ],
//                     )),
//               ),
//               Align(
//                 alignment: Alignment(0, -0.9),
//                 child: GestureDetector(
//                   onTap: () {
//                     onIconPressed();
//                   },
//                   child: Container(
//                     width: 35,
//                     height: 110,
//                     color: colorSidebar,
//                     alignment: Alignment.centerLeft,
//                     child: AnimatedIcon(
//                       icon: AnimatedIcons.menu_close,
//                       progress: _animationController.view,
//                       color: Colors.white,
//                       size: 25,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
