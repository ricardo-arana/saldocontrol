import 'package:flutter/material.dart';
import 'package:saldocontrol/repository/database_creator.dart';
import 'package:saldocontrol/screams/home.dart';

void main() async {
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
