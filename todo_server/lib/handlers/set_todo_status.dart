import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:todo_server/database.dart';
import 'package:todo_server/db/set_todo_status.dart';

Future<Response> completeTodo(Request req) async {
  final id = int.parse(req.params['id']!);
  await database.insert(CompleteTodo(id));
  return Response.ok(null);
}

Future<Response> undoTodo(Request req) async {
  final id = int.parse(req.params['id']!);
  await database.insert(UndoTodo(id));
  return Response.ok(null);
}
