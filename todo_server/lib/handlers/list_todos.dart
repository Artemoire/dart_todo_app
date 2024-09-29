import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:todo_server/database.dart';
import 'package:todo_server/db/query_todos.dart';

Future<Response> listTodos(Request req) async {
  return Response.ok(jsonEncode(await database.rawStmt(QueryTodos())),
      headers: {'Content-Type': 'application/json'});
}
