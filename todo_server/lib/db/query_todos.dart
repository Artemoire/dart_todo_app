import 'package:rawdog/rawdog.dart';
import 'package:todo/todo.dart';
import 'package:todo_server/db/todo_table.dart';

const _todos = TodoTable.name;
const _title = TodoTable.titleColumn;
const _id = TodoTable.idColumn;
const _done = TodoTable.doneColumn;

class QueryTodos implements RawSelectModel<List<TodoItem>> {

  @override
  List<TodoItem> marshal(List<List<Object?>> rows) {
     return rows.map((row) {
      return TodoItem(
        id: row[0] as int,
        title: row[1] as String,
      );
    }).toList();
  }

  @override
  String toSQL() => "SELECT $_id, $_title FROM $_todos WHERE $_done = FALSE;";

}