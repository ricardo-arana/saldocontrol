import 'package:flutter/material.dart';
import 'package:saldocontrol/common/Constanst.dart';
import 'package:saldocontrol/model/PassCardModel.dart';
import 'package:saldocontrol/repository/repository_service_tarjetadb.dart';

class AddTarjeta extends StatefulWidget {
  final BuildContext parentContext;
  AddTarjeta(this.parentContext);

  _AddTarjetaState createState() => _AddTarjetaState();
}

class _AddTarjetaState extends State<AddTarjeta> {
  List _tiposTarjetas = Constanst.tipoTarjetas;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentTipo;
  //controlers
  TextEditingController nameControler = TextEditingController();
  TextEditingController codeControler = TextEditingController();
  TextEditingController typeControler = TextEditingController();
  TextEditingController balanceControler = TextEditingController();
  //fin controlers
  @override
  Widget build(BuildContext context) {

    return 
    AlertDialog(
          title: new Text("Agregar Nueva tarjeta"),
          content: SizedBox(height: 180,child:  
          SingleChildScrollView(
      child: Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration( hintText: "Nombre"),
          controller: nameControler,
        ),
        TextField(
          decoration: InputDecoration( hintText: "código"),
          controller: codeControler,
          keyboardType: TextInputType.number,
        ),
        DropdownButton(
                value: _currentTipo,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              ),
        TextField(
          decoration: InputDecoration( hintText: "Saldo"),
          keyboardType: TextInputType.number,
          controller: balanceControler,
        )
      ],),
    ),),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Agregar"),
              onPressed: () async {
                int newId = await RepositoryServiceTarjeta.getNewId();
                var nuevaTarjeta = PassCardModel({"id": newId.toString(),
                                                  "name": nameControler.text,
                                                  "img":Constanst.tarjetaImgen[_currentTipo],
                                                  "code": codeControler.text,
                                                  "balance" : double.parse(balanceControler.text)
                                                  });
                await RepositoryServiceTarjeta.addTodo(nuevaTarjeta);
                Navigator.of(context).pop(nuevaTarjeta);
              },
            ),
          ],
        
        );
    
  }
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentTipo = _dropDownMenuItems[0].value;
    super.initState();
  }
   List<DropdownMenuItem<String>> getDropDownMenuItems() {
    
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _tiposTarjetas) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }
  void changedDropDownItem(String selectedTipo) {
    setState(() {
      _currentTipo = selectedTipo;
    });
  }
}

