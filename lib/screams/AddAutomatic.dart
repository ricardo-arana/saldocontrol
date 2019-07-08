import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:saldocontrol/common/Constanst.dart';
import 'package:saldocontrol/model/DebitoAutoModel.dart';
import 'package:saldocontrol/model/PassCardModel.dart';
import 'package:saldocontrol/repository/repository_service_debitodb.dart';
import 'package:saldocontrol/repository/repository_service_tarjetadb.dart';

class AddAutomatic extends StatefulWidget {
  AddAutomatic({Key key}) : super(key: key);

  _AddAutomaticState createState() => _AddAutomaticState();
}

class _AddAutomaticState extends State<AddAutomatic> {
  final formats = {
    InputType.time: DateFormat("HH:mm"),
  };
  TextEditingController titleController = TextEditingController();
  InputType inputType = InputType.time;
  bool editable = true;
  DateTime date;
  List<int> _daysSelected = List();
  Map<int, Color> _colorsButton = {
    1: Colors.grey,
    2: Colors.grey,
    3: Colors.grey,
    4: Colors.grey,
    5: Colors.grey,
    6: Colors.grey,
    7: Colors.grey,
  };
  final double _sizebuttonday = 25;
  List<PassCardModel> _listPassCard;
  PassCardModel _cardSelected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Pago automatico"),
      ),
      body: Container(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Titulo"),
                controller: titleController,
              ),
              Text("Días de la semana"),
              Wrap(
                children: diasSemanaWidget(),
              ),
              DateTimePickerFormField(
                inputType: inputType,
                format: formats[inputType],
                editable: editable,
                decoration: InputDecoration(
                    labelText: 'Hora', hasFloatingPlaceholder: false),
                onChanged: (dt) => setState(() => date = dt),
              ),
              FutureBuilder(
                future: RepositoryServiceTarjeta.getAllTarjetas(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PassCardModel>> snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton<PassCardModel>(
                      items: snapshot.data.map<DropdownMenuItem<PassCardModel>>(
                          (PassCardModel value) {
                        return DropdownMenuItem<PassCardModel>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _cardSelected = value;
                        });
                      },
                      isExpanded: false,
                      hint: Text('Seleccciona tarjeta'),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(
                height: 150,
                width: 230,
                child: Card(
                  child: _cardSelected != null
                      ? Image.asset(_cardSelected.img)
                      : Center(
                          child: Text("No hay tarjeta selecionada"),
                        ),
                ),
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Guardar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => guardarDebito(),
              )
            ]),
          ),
        ),
      ),
    );
  }

  addday(int i) {
    if (_daysSelected.any((e) => e == i)) {
      setState(() {
        _daysSelected.remove(i);
        _colorsButton[i] = Colors.grey;
      });
    } else {
      setState(() {
        _daysSelected.add(i);
        _colorsButton[i] = Colors.blue;
      });
    }
  }

  void changedDropDownItem(PassCardModel value) {
    setState(() {
      _cardSelected = value;
    });
  }

  List<DropdownMenuItem<PassCardModel>> getDropDownMenuItems() {
    List<DropdownMenuItem<PassCardModel>> items = new List();
    for (PassCardModel passcard in _listPassCard) {
      items.add(new DropdownMenuItem(
          value: passcard, child: new Text(passcard.name)));
    }
    return items;
  }

  List<Widget> diasSemanaWidget() {
    var returnWidget = List<SizedBox>();
    Constanst.diasDeSemana.forEach((k, v) {
      returnWidget.add(SizedBox(
        height: _sizebuttonday,
        width: _sizebuttonday,
        child: FloatingActionButton(
          backgroundColor: _colorsButton[k],
          child: Text(
            v,
            style: TextStyle(fontSize: 12),
          ),
          mini: true,
          onPressed: () => addday(k),
          heroTag: null,
        ),
      ));
    });
    return returnWidget;
  }

  guardarDebito() async {
    var newId = await RepositoryServiceDebitoDb.getNewId().toString();
    var data= DebitoAutoModel({ 
                                "id" : newId,
                                "name" : titleController.text,
                                "hora" : "${date.hour}:${date.minute}",
                                "idcard" : _cardSelected.id.toString(),
                                "dias" : _daysSelected.join(",")});
    RepositoryServiceDebitoDb.addDebito(data).then((t){
        Navigator.of(context).pop();
    });
  }
}
