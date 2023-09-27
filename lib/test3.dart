// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Menu> data = [];

//   @override
//   void initState() {
//     dataList.forEach((element) {
//       data.add(Menu.fromJson(element));
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         drawer: _drawer(data),
//         appBar: AppBar(
//           title: const Text('Expandable ListView'),
//         ),
//         body: ListView.builder(
//           itemCount: data.length,
//           itemBuilder: (BuildContext context, int index) =>
//               _buildList(data[index]),
//         ),
//       ),
//     );
//   }

//   Widget _drawer(List<Menu> data) {
//     return Drawer(
//         child: SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             UserAccountsDrawerHeader(
//                 margin: EdgeInsets.only(bottom: 0.0),
//                 accountName: Text('demo'),
//                 accountEmail: Text('demo@webkul.com')),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return _buildList(data[index]);
//               },
//             )
//           ],
//         ),
//       ),
//     ));
//   }

//   Widget _buildList(Menu list) {
//     if (list.subMenu.isEmpty)
//       return Builder(builder: (context) {
//         return ListTile(
//             // onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategory(list.name))),
//             leading: SizedBox(),
//             title: Text(list.name));
//       });
//     return ExpansionTile(
//       leading: Icon(list.icon),
//       title: Text(
//         list.name,
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//       children: list.subMenu.map(_buildList).toList(),
//     );
//   }
// }

// List dataList = [
//   {
//     "name": "Sales",
//     "icon": Icons.payment,
//     "subMenu": [
//       {"name": "Orders"},
//       {"name": "Invoices"}
//     ]
//   },
//   {
//     "name": "Marketing",
//     "icon": Icons.volume_up,
//     "subMenu": [
//       {
//         "name": "Promotions",
//         "subMenu": [
//           {"name": "Catalog Price Rule"},
//           {"name": "Cart Price Rules"}
//         ]
//       },
//       {
//         "name": "Communications",
//         "subMenu": [
//           {"name": "Newsletter Subscribers"}
//         ]
//       },
//       {
//         "name": "SEO & Search",
//         "subMenu": [
//           {"name": "Search Terms"},
//           {"name": "Search Synonyms"}
//         ]
//       },
//       {
//         "name": "User Content",
//         "subMenu": [
//           {"name": "All Reviews"},
//           {"name": "Pending Reviews"}
//         ]
//       }
//     ]
//   }
// ];
// class Menu {
//   String name;
//   IconData icon = Icons.ac_unit; // Initialize 'icon' with a default value.
//   List<Menu> subMenu = [];

//   Menu({required this.name, required this.subMenu, IconData? icon}) {
//   this.icon = icon ?? Icons.ac_unit; // Initialize 'icon' with a default value if it's not provided.
// }

//   Menu.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     if (json['icon'] != null) {
//       icon = json['icon'];
//     }
//     if (json['subMenu'] != null) {
//       subMenu.clear();
//       json['subMenu'].forEach((v) {
//         subMenu.add(Menu.fromJson(v));
//       });
//     }
//   }
// }

