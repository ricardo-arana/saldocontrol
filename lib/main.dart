import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:saldocontrol/repository/database_creator.dart';
import 'package:saldocontrol/screams/home.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

void printMessage(String msg) => print('[${DateTime.now()}] $msg');

void printPeriodic() => printMessage("Periodic!");
void printOneShot() => printMessage("One shot!");

Future<void> main() async {
  final int periodicID = 0;
  final int oneShotID = 1;

  // Start the AlarmManager service.
  await AndroidAlarmManager.initialize();

  printMessage("main run");
  await DatabaseCreator().initDatabase();
  runApp(MyApp());

  await AndroidAlarmManager.periodic(
      const Duration(seconds: 5), periodicID, printPeriodic,
      wakeup: true);
  await AndroidAlarmManager.oneShot(
      const Duration(seconds: 5), oneShotID, printOneShot);
  
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
