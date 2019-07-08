
import 'package:saldocontrol/model/PassCardModel.dart';

class DebitoAutoModel{
  int id;
  String name;
  String hora;
  PassCardModel card;
  List<int> dias;

  factory DebitoAutoModel(Map map){
    try{
      return DebitoAutoModel.create(map);
    }catch(ex){
      throw ex;
    }
  }


  DebitoAutoModel.create(Map map):
    id = int.parse(map["id"]),
    name = map["name"],
    hora = map["hora"],
    card = PassCardModel({ "id" : map["idCard"]}),
    dias = map["dias"].toString().split(",").map((item){
      return int.parse(item);
    }).toList();

}