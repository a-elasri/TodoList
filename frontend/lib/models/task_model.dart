class TaskModel{
  String title;
  String  id;
  String description;
  bool terminated;

  TaskModel({
    required this.title,
    required this.id,
    required this.description,
    required this.terminated
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['name'] as String,
      id: map['_id'] as String,
      description: map['description'] as String,
      terminated: map['terminated'] as bool
    );
  }
}