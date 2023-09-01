import 'package:flutter/material.dart';
import 'package:penyimpanan_lokal/test.dart';

void main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My app', // used by the OS task switcher
      home: SafeArea(
        child: TestPage(),
      ),
    ),
  );
}
