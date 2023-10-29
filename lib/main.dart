// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_2/component/settings/config.dart';

import 'package:web_2/pages/appointment/doctor_appointment.dart';
import 'package:web_2/pages/text5.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString("uid");
  print(uid);
  runApp(
     MyApp(uid: uid,
        // debugShowCheckedModeBanner: false,
        //scrollBehavior: CustomScrollBehavior(),
        // home: const Test5(),//email==null?Login():Home(),

        ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.uid});
  final String? uid;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: const Test5(), //
     // const DoctorAppointment(),
    );
  }
}
