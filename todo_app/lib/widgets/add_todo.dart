import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/todo.dart';
import 'package:todo_app/api/api.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController _todoController = TextEditingController();
  final StreamController<TodoItem> newTodos;

  AddTodo({super.key, required this.newTodos});

  _createTodo() async {
    var title = _todoController.text.trim();
    if (title == "") return;
    var todo = await postTodo(title);
    _todoController.clear();
    newTodos.add(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _todoController,
            decoration: const InputDecoration(labelText: 'TODO'),
          ),
        ),
        IconButton(
          onPressed: _createTodo,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
