import 'package:flutter/material.dart';
import 'package:saldocontrol/model/PassCardModel.dart';
import 'package:saldocontrol/repository/repository_service_tarjetadb.dart';

class AddSaldo extends StatefulWidget {
  final PassCardModel passCardModel;
  AddSaldo({this.passCardModel});

  _AddSaldoState createState() => _AddSaldoState();
}

class _AddSaldoState extends State<AddSaldo> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Agregar Saldo"),
      content: SizedBox(
        height: 200,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(controller: textEditingController,
            decoration: InputDecoration( hintText: "Saldo"),
            keyboardType: TextInputType.number
            )
          ],),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Agregar"),
          onPressed: () async {
              double saldoActual = widget.passCardModel.balance;
              double saldoNuevo = double.parse(textEditingController.text) + saldoActual;
              PassCardModel todo = widget.passCardModel;
              todo.balance = saldoNuevo;

              await RepositoryServiceTarjeta.updateTodo(todo).then((t){
                Navigator.of(context).pop();
              });
          },
        ),
        FlatButton(
          child: Text("Cerrar"),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}