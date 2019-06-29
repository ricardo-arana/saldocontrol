import 'package:flutter/material.dart';
import 'package:saldocontrol/model/PassCardModel.dart';
import 'package:saldocontrol/myWidgets/PassCardDetall.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:saldocontrol/repository/repository_service_tarjetadb.dart';

class PassCards extends StatefulWidget {
  final List<PassCardModel> passCardList;
  final void Function() getTarjetas;
  PassCards({this.passCardList, this.getTarjetas});

  _PassCardsState createState() => _PassCardsState();
}

class _PassCardsState extends State<PassCards> {
  CarouselSlider carouselSlider;
  int _current = 0;
  List<PassCardModel> passCardModelList = List();

  @override
  void initState() {
    print("cantidad de tarjetas: ${widget.passCardList.length}");
    super.initState();
    getlist();
    print("passCardModelList: ${passCardModelList.length}");
  }

  Future getlist() async {
    var data = await RepositoryServiceTarjeta.getAllTarjetas();
    passCardModelList = List();
    setState(() {
      passCardModelList.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (passCardModelList.length > 0) {
      carouselSlider = CarouselSlider(
        height: 350.0,
        //aspectRatio: 11/9,
        viewportFraction: 0.95,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        onPageChanged: (i) {
          setState(() {
            _current = i;
          });
        },
        items: passCardModelList.map((card) {
          return PassCardDetall(
              passcard: card, refreshCard: getlist, deleteCard: openMenuCard);
        }).toList(),
      );

      return carouselSlider;
    } else {
      return Text("No hay tarjetas. Agrega una nueva :D");
    }
  }

  openMenuCard(PassCardModel card) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Esta seguro?"),
            content: SizedBox(
              height: 100,
              child: Text("Deseas eliminar la tarjeta ${card.name}?"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Si"),
                onPressed: () async {
                  RepositoryServiceTarjeta.deleteTarjeta(card).then((t) async {
                    print("tarjeta borrada ${card.name}");
                    print("current: ${_current}");
                    var newData =
                        await RepositoryServiceTarjeta.getAllTarjetas();
                    newData.forEach((tar) {
                      print("encontrada: ${tar.name}");
                    });
                    setState(() {
                      //passCardModelList.removeAt(_current);
                      passCardModelList = newData;
                      carouselSlider.jumpToPage(0);
                    });
                    Navigator.of(context).pop();
                  });
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }
}
