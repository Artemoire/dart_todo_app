class TodoItem {
  final int id;
  final String title;
  final bool done;

  TodoItem({required this.id, required this.title, required this.done});

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'done': done};

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'] as int,
      title: json['title'] as String,
      done: json['done'] as bool
    );
  }
}
