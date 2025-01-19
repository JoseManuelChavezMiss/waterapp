import 'package:flutter/material.dart';
import 'package:waterapp/Config/DioConfig.dart';
import 'package:dio/dio.dart';
import 'package:waterapp/Repositories/AdministrativeRepository/administrative_repository.dart';

class AdministrativePanel extends StatelessWidget {
  const AdministrativePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = AdministrativeRepository();

    return Scaffold(
      appBar: AppBar(
        title: Text('Administrative Panel'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: repository.listUsersByRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final users = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DataTable(
                    columnSpacing: 20.0,
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blueGrey),
                    headingTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'ID',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Nombre',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Teléfono',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Rol Nombre',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Estado',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Acciones',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: users.map((user) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(user['id'].toString())),
                          DataCell(Text(user['nombre'])),
                          DataCell(Text(user['telefono'])),
                          DataCell(Text(user['rol_nombre'])),
                          DataCell(Text(user['estado'])),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Acción de editar
                                },
                              ),
                              Switch(
                                value: user['estado'] == 'Activo',
                                onChanged: (bool value) {
                                  // Acción de cambiar estado
                                },
                              ),
                            ],
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class AdministrativePanel extends StatelessWidget {
//   const AdministrativePanel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Administrative Panel'),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             margin: EdgeInsets.all(16.0),
//             padding: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blueGrey),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: DataTable(
//               columnSpacing: 20.0,
//               headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blueGrey),
//               headingTextStyle: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
//               columns: const <DataColumn>[
//                 DataColumn(
//                   label: Text(
//                     'ID',
//                     style: TextStyle(fontStyle: FontStyle.italic),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Nombre',
//                     style: TextStyle(fontStyle: FontStyle.italic),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Teléfono',
//                     style: TextStyle(fontStyle: FontStyle.italic),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Rol Nombre',
//                     style: TextStyle(fontStyle: FontStyle.italic),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Estado',
//                     style: TextStyle(fontStyle: FontStyle.italic),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Acciones',
//                     style: TextStyle(fontStyle: FontStyle.italic),
//                   ),
//                 ),
//               ],
//               rows: <DataRow>[
//                 DataRow(
//                   cells: <DataCell>[
//                     DataCell(Text('1')),
//                     DataCell(Text('Juan Perez')),
//                     DataCell(Text('123456789')),
//                     DataCell(Text('Admin')),
//                     DataCell(Text('Activo')),
//                     DataCell(Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             // Acción de editar
//                           },
//                         ),
//                         Switch(
//                           value: true,
//                           onChanged: (bool value) {
//                             // Acción de cambiar estado
//                           },
//                         ),
//                       ],
//                     )),
//                   ],
//                 ),
//                 DataRow(
//                   cells: <DataCell>[
//                     DataCell(Text('2')),
//                     DataCell(Text('Maria Lopez')),
//                     DataCell(Text('987654321')),
//                     DataCell(Text('User')),
//                     DataCell(Text('Inactivo')),
//                     DataCell(Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             // Acción de editar
//                           },
//                         ),
//                         Switch(
//                           value: false,
//                           onChanged: (bool value) {
//                             // Acción de cambiar estado
//                           },
//                         ),
//                       ],
//                     )),
//                   ],
//                 ),
//                 // Agrega más filas según sea necesario
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class AdministrativePanel extends StatelessWidget {
//   const AdministrativePanel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Administrative Panel'),
//       ),
//       body: Center(
//         child: Text(
//           'Panel Administrativo',
//           style: TextStyle(
//             fontSize: 35,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue,
//           ),
//         ),
//       ),
//     );
//   }
// }