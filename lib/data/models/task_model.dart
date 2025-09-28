class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createdDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      id: jsonData["_id"],
      title: jsonData["title"],
      description:jsonData["description"],
      status: jsonData["status"],
      createdDate:jsonData["createdDate"],
    );
  }

  
}
