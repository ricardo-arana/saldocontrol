import 'package:flutter/material.dart';
import 'package:saldocontrol/common/Constanst.dart';
import 'package:saldocontrol/model/PassCardModel.dart';
import 'package:saldocontrol/repository/repository_service_tarjetadb.dart';
import 'package:saldocontrol/screams/AddSaldo.dart';
import 'package:saldocontrol/screams/AddViaje.dart';

class PassCardDetall extends StatefulWidget {
  final PassCardModel passcard;
  final void Function() refreshCard;
  final void Function(PassCardModel) deleteCard;
  const PassCardDetall({this.passcard,this.refreshCard,this.deleteCard});

  @override
  _PassCardDetallState createState() => _PassCardDetallState();
}

class _PassCardDetallState extends State<PassCardDetall> {
  double currValue = 0.0;
  PassCardModel passCardModel;

  @override
  initState() {
    super.initState();
    passCardModel = widget.passcard;
  }

  void _handleValue(double value) {
    setState(() {
      currValue = value;
    });
  }

  void loadCard() async {
    var dataCard = await RepositoryServiceTarjeta.getCardById(widget.passcard);
    setState(() {
      passCardModel = dataCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Container(
          child: ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onLongPress: () => widget.deleteCard(passCardModel),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          passCardModel.img,
                          height: 200.0,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[900].withOpacity(0.5)),
                            constraints: BoxConstraints.expand(height: 55.0),
                          ),
                        ),
                        Positioned(
                          left: 10.0,
                          bottom: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                "Saldo: " +
                                    passCardModel.balance.toStringAsFixed(2),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                              Container(
                                width: 250.0,
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  passCardModel.code,
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 5.0,
                          bottom: 10.0,
                          child: Text(
                            passCardModel.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: IntrinsicHeight(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: RaisedButton(
                                child: Text("Agregar Saldo"),
                                onPressed: () {
                                  _showDialogAddSaldo(widget.passcard);
                                },
                                color: Colors.lightGreen,
                              ),
                            ),
                            Expanded(
                              child: RaisedButton(
                                child: Text("Agregar Viaje"),
                                onPressed: () {
                                  _showDialogAddViaje(widget.passcard);
                                },
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void _showDialogAddViaje(PassCardModel card) {
    var nameCard = Constanst.tarjetaImgen.keys.firstWhere(
        (k) => Constanst.tarjetaImgen[k] == card.img,
        orElse: () => null);
    var prices = Constanst.saldos[nameCard];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddViaje(
          initialValue: currValue,
          onValueChange: _handleValue,
          prices: prices,
          tarjeta: widget.passcard,
        );
      },
    ).then((t) {
      loadCard();
    });
  }

  void _showDialogAddSaldo(PassCardModel card) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSaldo(
          passCardModel: widget.passcard,
        );
      },
    ).then((t) {
      loadCard();
    });
  }

  
}
