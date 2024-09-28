import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:todo_server/database.dart';
import 'package:todo_server/db/delete_todo.dart';

Future<Response> deleteTodo(Request req) async {
  final id = int.parse(req.params['id']!);
  await database.insert(DeleteTodo(id: id));
  return Response.ok(null);
}
