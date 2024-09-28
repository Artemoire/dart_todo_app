import 'package:rawdog/rawdog.dart';
import 'package:todo_server/db/todo_table.dart';

const _todos = TodoTable.name;
const _id = TodoTable.idColumn;
const _done = TodoTable.doneColumn;

class SetTodoStatus implements RawInsertModel {
  final int id;
  final String done;

  SetTodoStatus({required this.id, required bool isDone})
      : done = isDone ? "TRUE" : "FALSE";

  @override
  String toSQL() => "UPDATE $_todos SET $_done = $done WHERE $_id = $id;";
}

class CompleteTodo extends SetTodoStatus {
  CompleteTodo(int id) : super(id: id, isDone: true);
}

class UndoTodo extends SetTodoStatus {
  UndoTodo(int id) : super(id: id, isDone: false);
}
