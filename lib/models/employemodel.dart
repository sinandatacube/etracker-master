// [{"_id":"63996e3618d0dec1565064e9",
// "empcode":"sn00fdg",
// "name":"gdfsg",
// "usename":"gsfdg",
// "password":"dgfdsg",
// "age":25,
// "number":88939484552,
// "__v":0}

import 'dart:core';

class Employess {
  final List<EmployeeClass> employess;

  Employess({required this.employess});

  factory Employess.fromJson(Map<String, dynamic> json) => Employess(
      employess: List<EmployeeClass>.from(
              (json['items'] as List).map((e) => EmployeeClass.fromjSON(e)))
          .toList());
}

class EmployeeClass {
  final String empCode;
  final String id;
  final String userName;
  final String lastName;
  final String number;
  final String role;
  final String age;

  EmployeeClass(
      {required this.empCode,
      required this.id,

      required this.userName,
      required this.lastName,
      required this.role,
      
      required this.age,
      required this.number});

  factory EmployeeClass.fromjSON(Map<String, dynamic> json) => EmployeeClass(
      empCode: json['empcode'],
      id: json["_id"],
      userName: json['usename'],
      lastName: json['name'],
      role: json['position'],
      age: json['age'].toString(),
      number: json['number'].toString());
}
