class AllAttendenceReportModel {
  final List<AttendenceReportModel> data;

  AllAttendenceReportModel({required this.data});

  factory AllAttendenceReportModel.fromJson(Map<String, dynamic> json) =>
      AllAttendenceReportModel(
        data: List<AttendenceReportModel>.from(
          (json['attendence'] as List)
              .map((e) => AttendenceReportModel.fromJson(e))
              .toList(),
        ),
      );
}

class AttendenceReportModel {
  final String empCode;
  final String name;
  final String position;
  final String worktime;
  final String overtime;

  AttendenceReportModel({
    required this.empCode,
    required this.overtime,
    required this.name,
    required this.position,
    required this.worktime,
  });

  factory AttendenceReportModel.fromJson(Map<String, dynamic> json) =>
      AttendenceReportModel(
        position: json["position"],
        worktime: json['worktime'],
        empCode: json['empcode'],
        name: json['name'],
        overtime: json['overtime'],
      );
}
