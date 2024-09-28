import 'package:flutter/material.dart';
import 'package:todo/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.onDelete});

  final List<TodoItem> items;
  final Function(TodoItem, bool?) onChanged;
  final Function(TodoItem) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return TodoListItem(
          item: items[index],
          onChanged: (value) => onChanged(items[index], value),
          onDelete: () => onDelete(items[index]),
        );
      },
    );
  }
}

class TodoListItem extends StatelessWidget {
  const TodoListItem(
      {super.key,
      required this.item,
      required this.onChanged,
      required this.onDelete});

  final TodoItem item;
  final Function(bool?) onChanged;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      leading: Checkbox(value: item.done, onChanged: onChanged),
      trailing: IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
    );
  }
}
