import 'dart:io';

import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:todo_server/database.dart';
import 'package:todo_server/db/todo_table.dart';
import 'package:todo_server/handlers/create_todo.dart';
import 'package:todo_server/handlers/list_todos.dart';
import 'package:todo_server/handlers/set_todo_status.dart';

final _router = Router()
  ..get('/', listTodos)
  ..post('/<id>/status', completeTodo)
  ..delete('/<id>/status', undoTodo)
  ..post('/', createTodo);

void main(List<String> args) async {
  
  await postgresDatabase.open(
      Endpoint(
        host: Platform.environment['POSTGRES_DB_HOST']!,
        database: 'postgres',
        username: 'user',
        password: 'pass',        
        port: int.parse(Platform.environment['POSTGRES_DB_PORT']!),
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable));

  await postgresDatabase
      .execute('''CREATE TABLE IF NOT EXISTS ${TodoTable.name} (
  ${TodoTable.idColumn} SERIAL PRIMARY KEY,
  ${TodoTable.titleColumn} VARCHAR(255) NOT NULL,
  ${TodoTable.doneColumn} BOOLEAN DEFAULT FALSE NOT NULL
);''');

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
