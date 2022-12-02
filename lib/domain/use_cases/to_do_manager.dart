
import 'package:misiontic_todo/data/repositories/database.dart';
import 'package:misiontic_todo/domain/models/to_do.dart';

abstract class ToDoManager {
  static final ToDoRepository _repository = ToDoRepository();

  static Future<void> initialize() async {
    // TODO: Conecta la aplicacion a la base de datos usando connectDatabase.
    // TODO: Luego de establecer la conexion crea la tabla usando createTable.
    await _repository.connectDatabase();
    await _repository.createTable(database: _repository.database);

  }

  static Future<void> save({
    required ToDo toDo,
  }) async {
    // TODO: Usa el metodo insert del repositorio de ToDos.
    await _repository.insert(database:_repository.database, data: toDo);
  }

  static Future<List<ToDo>> getAll({
    String? orderBy,
  }) async {
    // TODO: Usa el metodo readRecords del repositorio de ToDos y retorna la lista de ToDos
    return await _repository.readRecords(database: _repository.database,orderBy: orderBy);
  }

  static Future<void> update({required ToDo toDo}) async {
    // TODO: Usa el metodo update del repositorio de ToDos, filtrando usando toDo.uuid
    _repository.update(database: _repository.database, where: "uui= ?", whereArgs: [toDo.uuid], data: toDo);
  }

  static Future<void> delete({required ToDo toDo}) async {
    // TODO: Usa el metodo delete del repositorio de ToDos, filtrando usando toDo.uuid
    _repository.delete(database: _repository.database, where: "uui= ?", whereArgs: [toDo.uuid]);
  }

  static Future<void> deleteAll() async {
    // TODO: Usa el metodo truncate del repositorio de ToDos.
    _repository.truncate(database: _repository.database);

  }
}
