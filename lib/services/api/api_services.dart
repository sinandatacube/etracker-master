import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:employee_manage/config/config.dart';

import "package:http/http.dart" as http;

class ApiServices {
  /// add task

  addEmployee(
      {required name,
      required age,
      required code,
      required last,
      required number,
      required psw,
      required role,
      required salary}) async {
    var client = http.Client();
    try {
      var body1 = {
        "empcode": code,
        "name": last,
        "usename": name,
        "password": psw,
        "age": age,
        "number": number,
        "position": role,
        "salary": salary
      };
      var res = await client.post(Uri.parse(addEmpUrl),
          headers: {"Content-Type": "application/json"},
          // encoding: Encoding.getByName(name)
          body: jsonEncode(body1));
      log(body1.toString(), name: 'api body');
      log(res.body, name: 'api res');
      if (res.statusCode == 200) {
        var body = res.body;
        return jsonDecode(body);
      } else {
        log("!200");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //// get employess

  fetchEployess() async {
    // var client = http.Client();
    try {
      var res = await http.get(
        Uri.parse(getEmpUrl),
        headers: {"Content-Type": "application/json"},
      );
      log(res.body);
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      log(e.toString());
      return "error";
    }
  }

  addTask({required code, required date, required name, required tasks}) async {
//     {
//   "empcode":"001",
//   "name":"sinan",
//   "startdate":"15-12-22",
//   "deadline":"15-12-22",
//   "task":"sdfsdfg"

// }
    Map body1 = {
      "name": name,
      "empcode": code,
      "deadline": date,
      "task": tasks,
      "startdate": DateTime.now().toString().split(",")[0],
    };

    try {
      var res = await http.post(Uri.parse(addTaskUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body1));
      log(addTaskUrl);
      log(res.body);
      if (res.statusCode == 200) {
        // var body = jsonDecode(res.body);
        return "ok";
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

  ///get tasks

  getTasks() async {
    try {
      var res = await http.get(
        Uri.parse(getTask),
        headers: {"Content-Type": "application/json"},
      );
      log(res.body);
      if (res.statusCode == 200) {
        //  var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return jsonDecode(res.body);
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

//// deleteTask
  deleteTask(id) async {
    try {
      Map body = {"id": id};
      var res = await http.post(Uri.parse(deleteTaskUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      log(res.body);
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

//// get employeee tasks by id

  fetchTasksById({required id}) async {
    try {
      Map body = {"empcode": id};

      var res = await http.post(Uri.parse(getEmployeeTasksUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      log(res.toString());
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

//// delete employeeee

  deleteEmployee({required id}) async {
    try {
      Map body = {"_id": id};

      var res = await http.post(Uri.parse(deleteEmployeeUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      log(res.toString());
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

  ///////// update Task

  updateTask(
      {required code,
      required name,
      required date,
      required deadline,
      required task,
      required id}) async {
    // {
//  "empcode": "001",
//  "name": "sinan",
//  "startdate": "12-11-22",
//  "deadline": "12-11-22",
//   "task": "do yours",
//   "status": 1
// }
    try {
      Map body = {
        "empcode": code,
        "name": name,
        "startdate": date,
        "deadline": deadline,
        "task": task,
        "status": 1
      };

      var res = await http.put(Uri.parse("$updateTaskUrl$id"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      log(res.body, name: 'body');

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

//////// leaves

  getAllLeaves() async {
    try {
      var res = await http.get(
        Uri.parse(allLeavesUrl),
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

//////// attendence

  getAllAttendence() async {
    try {
      var res = await http.get(
        Uri.parse(allAttendenceUrl),
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

//////// attendence report

  getAllAttendenceReport(String date) async {
    try {
      Map body = {"date": date};
      print(body);
      var res = await http.post(
        Uri.parse(
          attendenceReportUrl,
        ),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

//////// attendence report

  getAllExpensesReport() async {
    try {
      var res = await http.get(
        Uri.parse(
          getAllExpensesUrl,
        ),
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

  updatePaidExpense(String id) async {
    try {
      var res = await http.put(
        Uri.parse(
          updateExpenseUrl + id,
        ),
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

  ///// update url

  updateLeave({required id, required status}) async {
    try {
      Map body = {"id": id, "status": status};
      var res = await http.post(Uri.parse(updateLeaveUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));

      log(res.body.toString());

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      print(e);
      return "error";
    }
  }

/////// notifications

  fetchNotification() async {
    try {
      var res = await http.get(
        Uri.parse(getNotificationUrl),
        headers: {"Content-Type": "application/json"},
      );

      log(res.body.toString());

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

////// add notifications

  createNotification(
      {required title, required description, required date}) async {
    try {
      Map body = {"title": title, "description": description, "date": date};
      var res = await http.post(Uri.parse(insertNotificationUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));

      log(res.body.toString());

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }

////// delete

  deleteNotification({required id}) async {
    try {
      var res = await http.delete(
        Uri.parse('$deleteNotificationUrl$id'),
        headers: {"Content-Type": "application/json"},
      );

      log(res.body.toString());

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        log(res.body, name: 'body');
        return body;
      } else {
        return "!200";
      }
    } on SocketException {
      return "noNetwork";
    } catch (e) {
      return "error";
    }
  }
}
