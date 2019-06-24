import 'package:saldocontrol/model/PassCardModel.dart';
import 'package:saldocontrol/repository/database_creator.dart';
import 'package:saldocontrol/repository/tables/TarjetaTable.dart';

class RepositoryServiceTarjeta{
  static Future<List<PassCardModel>> getAllTarjetas() async {
    final sql = '''SELECT * FROM ${TarjetaTable.tableName}''';
    final data = await db.rawQuery(sql);
    List<PassCardModel> todos = List();

    for (final node in data) {
      final todo = PassCardModel.fromJson(node);
      todos.add(todo);
    }
    return todos;
  }

  static Future<void> addTodo(PassCardModel tarjeta) async {

    final sql = '''INSERT INTO ${TarjetaTable.tableName}
    (
      ${TarjetaTable.id},
      ${TarjetaTable.name},
      ${TarjetaTable.img},
      ${TarjetaTable.code},
      ${TarjetaTable.balance}
    )
    VALUES (?,?,?,?,?)''';
    List<dynamic> params = [tarjeta.id, tarjeta.name, tarjeta.img, tarjeta.code, tarjeta.balance];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add Tarjeta', sql, null, result, params);
  }

  static Future<void> deleteTarjeta(PassCardModel todo) async {

    final sql = '''DELETE FROM ${TarjetaTable.tableName}
    WHERE ${TarjetaTable.id} = ?
    ''';

    List<dynamic> params = [todo.id];
    final result = await db.rawUpdate(sql, params);

    DatabaseCreator.databaseLog('Delete todo', sql, null, result, params);
  }

  static Future<void> updateTodo(PassCardModel todo) async {
    final sql = '''UPDATE ${TarjetaTable.tableName}
    SET ${TarjetaTable.name} = ? ,
        ${TarjetaTable.balance} = ?
    WHERE ${TarjetaTable.id} = ?
    ''';

    List<dynamic> params = [todo.name,todo.balance , todo.id];
    final result = await db.rawUpdate(sql, params);

    DatabaseCreator.databaseLog('Update todo', sql, null, result, params);
  }

  static Future<int> todosCount() async {
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${TarjetaTable.tableName}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }

  static Future<int> getNewId() async {
    final data = await db.rawQuery('''SELECT MAX(ID) FROM ${TarjetaTable.tableName}''');

    int count = data[0].values.elementAt(0);
    print(count);
    
    int idForNewItem = count == null ? 1 : count+1;
    print(idForNewItem);
    return idForNewItem;
  }

  static Future<PassCardModel> getCardById(PassCardModel passCardModel) async {
    final sql = '''SELECT * FROM ${TarjetaTable.tableName}
                                      WHERE ${TarjetaTable.id} = ${passCardModel.id}''';
    final data = await db.rawQuery(sql);
    PassCardModel  newPassCard = PassCardModel.fromJson(data[0]);
    return newPassCard;
    
  }

}
