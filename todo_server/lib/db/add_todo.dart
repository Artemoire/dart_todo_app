import 'package:rawdog/rawdog.dart';
import 'package:todo/todo.dart';
import 'package:todo_server/db/todo_table.dart';

const _todos = TodoTable.name;
const _id = TodoTable.idColumn;
const _title = TodoTable.titleColumn;

// TODO: returning
class AddTodo implements RawSelectModel<TodoItem> {
  final String title;

  AddTodo(this.title);
  
  @override
  String toSQL() => "INSERT INTO $_todos ($_title) VALUES ('$title') RETURNING $_id;";
  
  @override
  TodoItem marshal(List<List<Object?>> rows) => TodoItem(id: rows[0][0] as int, title: title, done: false);
  
}