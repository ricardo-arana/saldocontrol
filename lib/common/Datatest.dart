
import 'package:saldocontrol/common/Constanst.dart';
import 'package:saldocontrol/model/PassCardModel.dart';

class Datatest{
  

   List<PassCardModel> getTarjetas(){
      var data1 = PassCardModel(
   { "id": 1,
   "name": "Lima pass",
   "img" : Constanst.imgCardLimaPass,
   "code" : "3234242",
   "balance" : 12.70});
    List<PassCardModel> valor = List<PassCardModel>();
    valor.add(data1);
    return valor;
   }
}