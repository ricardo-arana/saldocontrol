
import 'package:saldocontrol/repository/database_creator.dart';
import 'package:saldocontrol/model/DebitoAutoModel.dart';
import 'package:saldocontrol/repository/tables/DebitoTable.dart';

class RepositoryServiceDebitoDb{
  static Future<List<DebitoAutoModel>> getAllDebito() async {
    final sql = '''SELECT * FROM ${DebitoTable.tableName} ''';
    final data = await db.rawQuery(sql);

    List<DebitoAutoModel> debitos = List();

    for(final item in data){
      final debito = DebitoAutoModel(item);
      debitos.add(debito);
    }
    return debitos;

  }

  static Future<void> addDebito(DebitoAutoModel debitoAutoModel) async {

    final sql = '''INSERT INTO ${DebitoTable.tableName}
    (
      ${DebitoTable.id},
      ${DebitoTable.name},
      ${DebitoTable.hora},
      ${DebitoTable.idCard},
      ${DebitoTable.dias}
    )
    VALUES (?,?,?,?,?)''';
    List<dynamic> params = [debitoAutoModel.id, debitoAutoModel.name,
                            debitoAutoModel.hora, debitoAutoModel.card.id,
                            debitoAutoModel.dias.join(",")];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add Tarjeta', sql, null, result, params);
  }

  static Future<int> getNewId() async {
    final data = await db.rawQuery('''SELECT MAX(ID) FROM ${DebitoTable.tableName}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count == null ? 1 : count+1;
    return idForNewItem;
  }
}