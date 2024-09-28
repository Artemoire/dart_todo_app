import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/todo.dart';

const _host = 'localhost';

Future<List<TodoItem>> fetchTodos() async {
  final response = await http.get(Uri.parse('http://$_host:8080/'));
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List<dynamic>)
        .map((jsonItem) => TodoItem.fromJson(jsonItem))
        .toList();
  } else {
    throw Exception('Failed to load todos');
  }
}

Future<TodoItem> postTodo(String title) async {
  final response =
      await http.post(Uri.parse('http://$_host:8080/'), body: title);

  if (response.statusCode == 200) {
    return TodoItem.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save todo');
  }
}

Future<void> completeTodo(TodoItem item) async {
  final response = await http.post(Uri.parse('http://$_host:8080/${item.id}/status'));
  
  if (response.statusCode != 200) {
    throw Exception('Failed to complete todo');
  }
}

Future<void> undoTodo(TodoItem item) async {
  final response = await http.delete(Uri.parse('http://$_host:8080/${item.id}/status'));

  if (response.statusCode != 200) {
    throw Exception('Failed to undo todo');
  }
}

Future<void> deleteTodo(TodoItem item) async {
  final response = await http.delete(Uri.parse('http://$_host:8080/${item.id}'));

  if (response.statusCode != 200) {
    throw Exception('Failed to delete todo');
  }
}