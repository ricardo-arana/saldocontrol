import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saldocontrol/screams/home.dart';

class Loading extends StatefulWidget {
  const Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
@override
  void initState() {
    Timer(Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()),
  (Route<dynamic> route) => false,);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    Container(
      color: Colors.white,
      child: Center(
        
        child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          new CircularProgressIndicator(),
          new Text("Espere...",style: TextStyle(fontSize: 18),),
        ],
      ),
      ),
    )
    ,);
  }
}