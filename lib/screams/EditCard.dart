import 'package:flutter/material.dart';
import 'package:saldocontrol/common/Constanst.dart';
import 'package:saldocontrol/model/PassCardModel.dart';
import 'package:saldocontrol/myWidgets/Loading.dart';
import 'package:saldocontrol/repository/repository_service_tarjetadb.dart';



class EditCard extends StatefulWidget {
  final PassCardModel passCardModel;
  EditCard({this.passCardModel,this.title});

  final String title;

  @override
  _EditCardState createState() => new _EditCardState();
}

ScrollController _controller;

class _EditCardState extends State<EditCard> {
  List _tiposTarjetas = Constanst.tipoTarjetas;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentTipo;
  //controlers
  TextEditingController nameControler = TextEditingController();
  TextEditingController codeControler = TextEditingController();
  TextEditingController typeControler = TextEditingController();
  TextEditingController balanceControler = TextEditingController();
  
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
  @override
    void initState() {
      _controller = ScrollController();
      _controller.addListener(_scrollListener);

      nameControler.text = widget.passCardModel.name;
      codeControler.text = widget.passCardModel.code;
      balanceControler.text = widget.passCardModel.balance.toStringAsFixed(2);
      _dropDownMenuItems = getDropDownMenuItems();
      _currentTipo = _dropDownMenuItems[getIndexList(widget.passCardModel.img)].value;
      super.initState();
    }

  Color clr = Colors.lightGreen;
  _scrollListener() {
    
    if (_controller.offset > _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        clr = Colors.blueAccent;
      });
    }

    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        clr = Colors.lightBlue;
      });
    }

  }
  void changedDropDownItem(String selectedTipo) {
    setState(() {
      _currentTipo = selectedTipo;
    });
  }

  int getIndexList(String findValue){
    int returnValue = 0;
    String typeCard = "Lima Pass";
    Constanst.tarjetaImgen.forEach((type,img){
      if(findValue == img){
        typeCard = type;
      }
    });
    _tiposTarjetas.asMap().forEach((index, value) {
      if(value == typeCard){
        returnValue = index;
      }
    });
    print(returnValue);
    return returnValue;
  }
  @override
  Widget build(BuildContext context) {

    return Container(
              color: Colors.white,
              child:
             CustomScrollView(
              controller: _controller,
              slivers: <Widget>[    
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(widget.title,
                        style: const TextStyle(
                          shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.5, 1.5),
                                      blurRadius: 1.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    
                                  ],
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                    background: Hero(
                          tag: 'imageHero_${widget.passCardModel.id}',
                          child:Image.asset(
                          widget.passCardModel.img,
                          height: 200.0,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                  ),
                  backgroundColor: clr,                  
                )
                ,
                SliverFillRemaining(
                  child: Card(
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(width: MediaQuery.of(context).size.width * 0.65 ,child: 
                      Column(
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
        ),
        Container(height: 10,),
        Row(children: <Widget>[
          Expanded(child: 
          RaisedButton(child: Text("Guardar", style: TextStyle(color: Colors.white,),),
          onPressed: updateCard,
          color: Colors.blueAccent,
          ),
          ),
          Expanded(child: 
          RaisedButton(child: Text("Cancelar", style: TextStyle(color: Colors.white,),),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.green,)
          ,)
          
        ],),
        Row(children: <Widget>[
          Expanded(
          child: RaisedButton(child: Text("Eliminar tarjeta", style: TextStyle(color: Colors.white,),),
          onPressed: deleteCard,
            color: Colors.redAccent),
        )
        ],),
      ],),
                      ),
                    ),
                  ),
                )             
                ],
              ),
            );
  }

  void updateCard(){
    var newCard = PassCardModel({"id": widget.passCardModel.id.toString(),
                                "name": nameControler.text,
                                "img":Constanst.tarjetaImgen[_currentTipo],
                                "code": codeControler.text,
                                "balance" : double.parse(balanceControler.text)
                                });
    RepositoryServiceTarjeta.updateTodo(newCard).then((t){
       Route route = MaterialPageRoute(builder: (context) => Loading());
       Navigator.pushReplacement(context, route);
    });
  }

  void deleteCard(){
    var newCard = PassCardModel({"id": widget.passCardModel.id.toString(),
                                "name": nameControler.text,
                                "img":Constanst.tarjetaImgen[_currentTipo],
                                "code": codeControler.text,
                                "balance" : double.parse(balanceControler.text)
                                });
    RepositoryServiceTarjeta.deleteTarjeta(newCard).then((t){
      Route route = MaterialPageRoute(builder: (context) => Loading());
      Navigator.pushReplacement(context, route);
    });
  }
}