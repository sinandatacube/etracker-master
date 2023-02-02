class AllEmployeeAttendenceModel {
  final List<EmployeeAttendenceModel> data;

  AllEmployeeAttendenceModel({required this.data});

  factory AllEmployeeAttendenceModel.fromJson(Map<String, dynamic> json) =>
      AllEmployeeAttendenceModel(
        data: List<EmployeeAttendenceModel>.from(
          (json['attendence'] as List)
              .map((e) => EmployeeAttendenceModel.fromJson(e))
              .toList(),
        ),
      );
}

class EmployeeAttendenceModel {
  final String id;
  final String empCode;
  final String name;
  final String indate;
  final String outdate;
  final String inlocation;
  final String outlocation;
  final String overtime;
  final String workhours;
  final String status;

  EmployeeAttendenceModel(
      {required this.id,
      required this.empCode,
      required this.status,
      required this.name,
      required this.indate,
      required this.outdate,
      required this.overtime,
      required this.workhours,
      required this.outlocation,
      required this.inlocation});

  factory EmployeeAttendenceModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAttendenceModel(
          status: json["checkinstatus"].toString(),
          id: json['_id'],
          empCode: json['empcode'],
          name: json['name'],
          indate: json['indate'],
          outdate: json['outdate'],
          outlocation: json['outlocation'],
          overtime: json['overtime'],
          workhours: json['workhours'],
          inlocation: json['inlocation']);
}
