import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saldocontrol/model/PassCardModel.dart';
import 'package:saldocontrol/repository/repository_service_tarjetadb.dart';

class AddViaje extends StatefulWidget {
  AddViaje({this.onValueChange,this.initialValue,this.prices,this.tarjeta});

  final double initialValue;
  final void Function(double) onValueChange;
  final List<double> prices;
  final PassCardModel tarjeta; 

  _AddViajeState createState() => _AddViajeState();
}

class _AddViajeState extends State<AddViaje> {
  double _selectPrice = 0;
  void _handleValue(double value){
    setState(() {
      _selectPrice = value;
    });
    widget.onValueChange(value);
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController(text: "1.50");
    List<Row> selectable = widget.prices.map((price){
                    return Row(children: <Widget>[
                      Radio(
                        groupValue: _selectPrice,
                        value: price,
                        onChanged: _handleValue,
                     ),
                      Text("S/. ${price.toStringAsFixed(2)}")]);}).toList();
    selectable.add(Row(children: <Widget>[
      Radio(
                        groupValue: _selectPrice,
                        value: 99.99,
                        onChanged: _handleValue,
                     ),
                      Flexible(child:TextField(controller: editingController,keyboardType: TextInputType.number,))
                      
    ],));
    return AlertDialog(
      title: Text("Agregar Viaje"),
      content: SizedBox(
        height: 250,
        child: SingleChildScrollView(
            
            child: 
          Column(children: <Widget>[
            Text("Selecione una opción:"),
              Column(children: 
                selectable,
                crossAxisAlignment: CrossAxisAlignment.stretch
              ,)
          ],),),),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Agregar"),
              onPressed: () async {
                double saldoActual = widget.tarjeta.balance;
                double saldoViaje = _selectPrice == 99.99 ? double.parse(editingController.text) : _selectPrice;
                double saloNuevo = saldoActual - saldoViaje;
                PassCardModel pass = widget.tarjeta;
                pass.balance = saloNuevo;

                await RepositoryServiceTarjeta.updateTodo(pass).then(
                  (t){
                    Navigator.of(context).pop();
                  }
                );

              },
            ),
          ],

    );
  }
}