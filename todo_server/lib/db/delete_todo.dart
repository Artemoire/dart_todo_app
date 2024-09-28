import 'package:rawdog/rawdog.dart';
import 'package:todo_server/db/todo_table.dart';

const _todos = TodoTable.name;
const _id = TodoTable.idColumn;

class DeleteTodo implements RawInsertModel {
  final int id;
  DeleteTodo({required this.id});

  @override
  String toSQL() => "DELETE FROM $_todos WHERE $_id = $id;";
}