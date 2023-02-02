class AllTasks {
  final List<Task> tasks;

  AllTasks({required this.tasks});

  factory AllTasks.fromJson(Map<String, dynamic> json) => AllTasks(
        tasks: List<Task>.from(
          (json['items'] as List).map((e) => Task.fromJson(e)).toList(),
        ),
      );
}

class Task {
  final String empCode;
  final String startDate;
  final String deadLine;
  final String name;
  final String task;
  final String status;
  final String id;

  Task(
      {required this.empCode,
      required this.id,
      required this.startDate,
      required this.deadLine,
      required this.name,
      required this.task,
      required this.status});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      empCode: json['empcode'],
      id: json['_id'],
      startDate: json['startdate'],
      deadLine: json['deadline'],
      name: json['name'],
      task: json['task'],
      status: json['status'].toString());
}
