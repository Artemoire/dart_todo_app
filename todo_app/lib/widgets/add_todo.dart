import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController _todoController = TextEditingController();

  AddTodo({super.key, required this.addTodo});

  final Function(String) addTodo;

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
          onPressed: () => addTodo(_todoController.text),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
