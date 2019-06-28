import 'package:flutter/material.dart';
import 'package:saldocontrol/model/PassCardModel.dart';
import 'package:saldocontrol/myWidgets/PassCards.dart';
import 'package:saldocontrol/repository/repository_service_tarjetadb.dart';
import 'package:saldocontrol/screams/AddTarjeta.dart';

class Home extends StatefulWidget {
  
  const Home({Key key}) : super(key: key);
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PassCardModel> passCardList = List();

  @override
  initState() {
    super.initState();
    getTarjetas();
  }


  void getTarjetas() async {
    var data = await RepositoryServiceTarjeta.getAllTarjetas();
    setState(() {
      passCardList.addAll(data);
    });
  }

  @override
  void didUpdateWidget(Home oldWidget) {
    passCardList = List();
    getTarjetas();
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mis tarjetas"),),
      body: Container(
        child:
          Column(children: <Widget>[
              SizedBox(child:
              PassCards(passCardList: passCardList,getTarjetas: getTarjetas),
              height: 260,
            )
          ],)
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showDialog(context); 

        },
      ),
    );
  }

  void _showDialog(BuildContext context){
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTarjeta(context);
      },
    ).then((p){
      if (p != null){
          var newcard = p as PassCardModel;
          var newlist = passCardList;
          newlist.add(newcard);
          print("tarejta agregada: ${newcard.name}");
          setState(() {
            passCardList = newlist;
          });
      }
    });
    
  }
}