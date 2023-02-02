class AllLeaves {
  final List<Leaves> leaves;

  AllLeaves({required this.leaves});

  factory AllLeaves.fromJson(Map<String, dynamic> json) => AllLeaves(
        leaves: List<Leaves>.from(
          (json["leaves"] as List).map((e) => Leaves.fromJson(e)).toList(),
        ),
      );
}

class Leaves {
  final String id;
  final String empcode;
  final String name;
  final String date;
  final String reason;
  final String leaveDate;
  final String status;

  Leaves(
      {required this.id,
      required this.empcode,
      required this.name,
      required this.date,
      required this.reason,
      required this.leaveDate,
      required this.status});

  factory Leaves.fromJson(Map<String, dynamic> json) => Leaves(
      id: json["_id"],
      empcode: json["empcode"],
      name: json["name"],
      date: json["date"],
      reason: json["reason"],
      leaveDate: json["leavedate"],
      status: json["status"].toString());
}
