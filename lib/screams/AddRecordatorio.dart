import 'package:flutter/material.dart';
import 'package:saldocontrol/screams/AddAutomatic.dart';

class AddRecordatorio extends StatefulWidget {
  AddRecordatorio({Key key}) : super(key: key);

  _AddRecordatorioState createState() => _AddRecordatorioState();
}

class _AddRecordatorioState extends State<AddRecordatorio> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recordatios"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              alertAddIcon();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          alertAddIcon();
        },
      ),
    );
  }

  void alertAddIcon() {
    Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddAutomatic()),
                          );
  }
}
