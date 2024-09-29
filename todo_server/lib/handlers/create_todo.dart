import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:todo_server/database.dart';
import 'package:todo_server/db/add_todo.dart';

Future<Response> createTodo(Request req) async {
  final title = await req.readAsString();
  
  return Response.ok(jsonEncode(await database.rawStmt(AddTodo(title))),
      headers: {'Content-Type': 'application/json'});
}
