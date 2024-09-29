import 'dart:async';

import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController _todoController = TextEditingController();
  final StreamController<String> newTodos;

  AddTodo({super.key, required this.newTodos});

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
          onPressed: () => newTodos.add(_todoController.text),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
