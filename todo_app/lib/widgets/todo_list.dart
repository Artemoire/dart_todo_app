import 'package:flutter/material.dart';
import 'package:todo/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.items, required this.onChanged});

  final List<TodoItem> items;
  final Function(TodoItem, bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      itemCount: items.length,
      itemBuilder: (context, index) {
        return TodoListItem(
          item: items[index],
          onChanged: (value) => onChanged(items[index], value),
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
      leading: Checkbox(value: item.done, onChanged: onChanged),
    );
  }
}
