import 'package:flutter/material.dart';
import 'package:todo/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.items});

  final List<TodoItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      itemCount: items.length,
      itemBuilder: (context, index) {
        return TodoListItem(
          item: items[index],
          onChanged: (value) {}, // TODO: done
        );
      },
    );
  }
}

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.item, required this.onChanged});

  final TodoItem item;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      leading: Checkbox(value: false, onChanged: onChanged),
    );
  }
}
