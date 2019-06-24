
import 'package:saldocontrol/repository/tables/TarjetaTable.dart';

class PassCardModel{
  int id;
  String name;
  String img;
  String code;
  double balance;

  factory PassCardModel(Map map){
    try{
      return PassCardModel.create(map);
    }catch(ex){
      throw ex;
    }
  }

  PassCardModel.create(Map map) :
   id = int.parse(map["id"]),
   name = map["name"],
   img = map["img"],
   code = map["code"],
   balance = map["balance"];

    PassCardModel.fromJson(Map<String, dynamic> json) {
    this.id = json[TarjetaTable.id];
    this.name = json[TarjetaTable.name];
    this.img = json[TarjetaTable.img];
    this.code = json[TarjetaTable.code];
    try{
      this.balance = json[TarjetaTable.balance];
    }catch(ex){
      throw ex;
    }
    
    }
}