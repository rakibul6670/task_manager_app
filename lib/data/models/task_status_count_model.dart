class TaskStatusCountModel {
  final String id;
  final int sum;

  TaskStatusCountModel({required this.id, required this.sum});

  factory TaskStatusCountModel.fromJson(Map<String, dynamic> jsondata) {
    return TaskStatusCountModel(id: jsondata["_id"], sum:jsondata["sum"]);
  }
}
