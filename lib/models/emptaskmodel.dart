class AllEmployeeTaskModel {
  final List<EmployeeTaskModel> data;

  AllEmployeeTaskModel({required this.data});

  factory AllEmployeeTaskModel.fromJson(Map<String, dynamic> json) =>
      AllEmployeeTaskModel(
        data: List<EmployeeTaskModel>.from(
          (json['tasks'] as List)
              .map((e) => EmployeeTaskModel.fromJson(e))
              .toList(),
        ),
      );
}

class EmployeeTaskModel {
  final String id;
  final String empCode;
  final String deadLine;
  final String initialDate;
  final String task;
  final String status;

  EmployeeTaskModel(
      {required this.id,
      required this.empCode,
      required this.deadLine,
      required this.initialDate,
      required this.task,
      required this.status});

  factory EmployeeTaskModel.fromJson(Map<String, dynamic> json) =>
      EmployeeTaskModel(
          id: json['_id'],
          empCode: json['empcode'],
          deadLine: json['deadline'],
          initialDate: json['startdate'],
          task: json['task'],
          status: json['status'].toString());
}
