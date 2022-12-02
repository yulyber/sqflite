import 'package:misiontic_todo/data/entities/to_do.dart';
import 'package:misiontic_todo/domain/models/to_do.dart';
import 'package:misiontic_todo/domain/repositories/sqflite_interface.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ToDoRepository extends SqfliteInterface {
  late Database _database;

  Database get database => _database;

  @override
  Future<Database> connectDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      version: 1,
    );
    return _database;
  }

  @override
  Future<void> createTable({
    required Database database,
  }) async {
    // TODO: Carga y ejecuta el script para crear la tabla en la base de datos.
      String script = await loadScript();
      await database.execute(script);
  }

  @override
  Future<void> insert({
    required Database database,
    required ToDo data,
  }) async {
    // TODO: En la tabla 'todo_list' guarda data.record.
    // TODO-HINT: Para evitar errores por conflictos usa conflictAlgorithm = replace
    await database.insert('todo_list', data.record,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<ToDo>> read({
    required Database database,
    required String where,
    required List whereArgs,
    String? orderBy,
  }) async {
    // TODO: Usando where y whereArgs lee la base de datos.
    // TODO: Retorna una lista de ToDos convirtiendo los registros a ToDo.
    final records =await database.query('todo-list',where: where, whereArgs: whereArgs, orderBy: orderBy);
    return records.map((record)=>ToDoEntity.fromRecord(record)).toList();
  }

  @override
  Future<List<ToDo>> readRecords({
    required Database database,
    String? orderBy,
  }) async {
    // TODO: Lee todos los registros en 'todo_list'
    // TODO: Retorna una lista de ToDos convirtiendo los registros a ToDo.
      final records =await database.query('todo-list', orderBy: orderBy);
    return records.map((record)=>ToDoEntity.fromRecord(record)).toList();
  }

  @override
  Future<void> update(
      {required Database database,
      required String where,
      required List whereArgs,
      required ToDo data}) async {
    // TODO: Usando where y whereArgs actualiza la base de datos con data.record
    await database.update('todo-list', data.record,where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> delete(
      {required Database database,
      required String where,
      required List whereArgs}) async {
    // TODO: Usando where y whereArgs elimina registros de 'todo_list'.
  await database.delete('todo-list', where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> truncate({required Database database}) async {
    // SQLite `TRUNCATE` statement not allowed by SQFlite

    // TODO: Ejecuta un script DELETE sin filtrar para eliminar todos los registros.
    await database.execute('DELETE FROM todo_list');
  }

  @override
  Future<void> drop({required Database database}) async {
    await database.execute('DROP TABLE todo_list');
  }
}
