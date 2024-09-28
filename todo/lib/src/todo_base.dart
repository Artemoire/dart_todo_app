class TodoItem {
  final int id;
  final String title;

  TodoItem({required this.id, required this.title});

  Map<String, dynamic> toJson() => {'id': id, 'title': title};

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}
