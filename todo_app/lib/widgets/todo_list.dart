import 'package:flutter/material.dart';
import 'package:todo/todo.dart';
import 'package:todo_app/api/api.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.items, required this.newTodos});

  final List<TodoItem> items;
  final Stream<TodoItem> newTodos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return TodoListItem(
          item: widget.items[index],
          onChanged: (value) => _changeTodoStatus(index, value),
          onDelete: () => _deleteTodo(index),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widget.newTodos.listen(_addTodo);
  }

  _addTodo(TodoItem item) async {
    setState(() {
      widget.items.add(item);
    });
  }

  _changeTodoStatus(int index, bool? value) async {
    if (value == null) return;
    var item = widget.items[index];
    if (value) {
      await completeTodo(item);
    } else {
      await undoTodo(item);
    }

    setState(() {
      widget.items.replaceRange(index, index + 1,
          [TodoItem(id: item.id, title: item.title, done: value)]);
    });
  }

  _deleteTodo(int index) async {
    var item = widget.items[index];
    await deleteTodo(item);
    setState(() {
      widget.items.removeAt(index);
    });
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
