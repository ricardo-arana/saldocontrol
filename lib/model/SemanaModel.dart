

import 'package:saldocontrol/model/DebitoAutoModel.dart';

class SemanaModel{
  int id;
  int idDebitoAuto;
  String name;

  factory SemanaModel(Map map){
    try{
      return SemanaModel.create(map);
    }catch(ex){
      throw ex;
    }
  }

  SemanaModel.create(Map map):
  id = int.parse(map["id"]),
  idDebitoAuto = int.parse(map["idDebitoAuto"]),
  name = map["name"];
}