import 'package:flutter/material.dart';
import 'package:todo/todo.dart';
import 'package:todo_app/api/api.dart';
import 'package:todo_app/widgets/add_todo.dart';
import 'package:todo_app/widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<TodoItem>> futureTodoItems;

  void _addTodo(String title) async {
    if (title.isEmpty) return;
    final todo = await postTodo(title);
    final todoItems = await futureTodoItems; // TODO: state management ?
    setState(() {
      todoItems.add(todo);
    });
  }

  void _setDone(TodoItem todo, bool? done) async {
    if (done == null) return;
    if (done) {
      await completeTodo(todo);
    } else {
      await undoTodo(todo);
    }
    final todoItems = await futureTodoItems;
    var idx = todoItems.indexOf(todo);
    setState(() {
      todoItems.replaceRange(
          idx, idx + 1, [TodoItem(id: todo.id, title: todo.title, done: done)]);
    });
  }

  void _delete(TodoItem todo) async {
    await deleteTodo(todo);
    final todoItems = await futureTodoItems;
    setState(() {
      todoItems.remove(todo);
    });
  }

  @override
  void initState() {
    super.initState();
    futureTodoItems = fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AddTodo(addTodo: _addTodo),
            FutureBuilder(
                future: futureTodoItems,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: TodoList(
                        items: snapshot.data!,
                        onChanged: _setDone,
                        onDelete: _delete,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
