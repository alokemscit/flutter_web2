// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:web_2/pages/prescription/prescription_page.dart';
import 'package:web_2/test2.dart';

import 'pages/test4.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Test2(),
    );
  }
}




