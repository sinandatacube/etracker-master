import 'dart:developer';

import 'package:employee_manage/models/employemodel.dart';
import 'package:employee_manage/models/tmodel.dart';
import 'package:employee_manage/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  EmployeeClass? selectedEmployee;
  List<EmployeeClass> employees = [];
  List<Task> tasks = [];

  var employeeName = "";
  var employeeCode = "";
  var selectedDate = "";
  var editTasks = "";

  /// add employee
  bool isLoading = false;
  bool isTaskLoading = false;
  bool isDeleteLoading = false;

  ///

  addEmployee(
      {required name,
      required age,
      required code,
      required last,
      required number,
      required psw,
      required role,
      required salary
      }) async {
    isLoading = true;
    notifyListeners();
    var res = await ApiServices().addEmployee(
        name: name,
        age: age,
        code: code,
        last: last,
        number: number,
        psw: psw,
        role: role,
        salary:int.parse(salary.toString()));
    log(res.toString());
    if (res['success'] == 1) {
      isLoading = false;
      notifyListeners();
      return {'status': 'ok'};
    } else {
      isLoading = false;
      notifyListeners();
      return {'status': 'notOk', 'message': res['message']};
    }
  }

  ///// employess

  getEmployees() async {
    selectedDate = "";
    selectedEmployee = null;
    employeeCode = "";
    employeeName = "";
    var res = await ApiServices().fetchEployess();
    log(res.toString(), name: "employess");
    if (res != '!200' && res != "error" && res != "noNetwork") {
      var result = Employess.fromJson(res);
      // log(result.employess[1].lastName.toString());
      employees = result.employess;
      notifyListeners();
      return result;
    } else {
      log(res);
      return res;
    }
  }

/////// set employee

  setEmployee(data) {
    selectedEmployee = data;
    employeeName = selectedEmployee!.userName;
    employeeCode = selectedEmployee!.empCode;
    notifyListeners();
  }

  setDate(String data) {
    selectedDate = data.split(" ")[0];
    notifyListeners();
  }

  addTask(String tasks) async {
    if (employeeName.isEmpty) {
      return "emp empty";
    } else if (selectedDate.isEmpty) {
      return "date empty";
    } else {
      isTaskLoading = true;
      notifyListeners();
      // List task = tasks.split(",");
      var res = await ApiServices().addTask(
          code: employeeCode,
          date: selectedDate,
          name: employeeName,
          tasks: tasks);
          isTaskLoading = false;
          notifyListeners();
      return res;
    }
  }

  clearTaskCache() {
    selectedDate = "";
    selectedEmployee = null;
    employeeCode = "";
    employeeName = "";
    notifyListeners();
  }

//// get taskss

  getTasks() async {
    var res = await ApiServices().getTasks();
    log(res.toString(), name: "gettasks");
    if (res != '!200' && res != "error" && res != "noNetwork") {
      var result = AllTasks.fromJson(res);

      tasks = result.tasks;
      notifyListeners();
      return result;
    } else {
      log(res);
      return res;
    }
  }

  //// updateTask

  updateTask({required id, required cntr}) async {
    isTaskLoading = true;
    notifyListeners();
    var res = await ApiServices().updateTask(
        code: employeeCode,
        name: employeeName,
        date: DateTime.now().toString(),
        deadline: selectedDate,
        task: cntr,
        id: id);
    if (res != '!200' && res != "error" && res != "noNetwork") {
      isTaskLoading = false;
      notifyListeners();
      return "ok";
    } else {
      log(res);
      isTaskLoading = false;
      notifyListeners();
      return res;
    }
  }

  /// deleteTask

  deleteTask({required id}) async {
    log(tasks.toString());
    isDeleteLoading = true;
    notifyListeners();
    var res = await ApiServices().deleteTask(id);
    if (res['success'] == 1) {
      tasks.removeWhere((element) => element.id == id);
      log(tasks.toString());
    isDeleteLoading = false;

      notifyListeners();
    }
    isDeleteLoading = false;
    notifyListeners();
    return res;
  }

//// delete employeee

  deleteEmployee({required id}) async {
    isDeleteLoading = true;
notifyListeners();
    var res = await ApiServices().deleteEmployee(id: id);
    log(res.toString());
    if (res != '!200' && res != "error" && res != "noNetwork") {
      employees.removeWhere((element) => element.id == id);
      isDeleteLoading = false;
      notifyListeners();
      return {"message": "employee deleted successfully"};
    } else {
      log(res);
      switch (res) {
        case "!200":
          res = {"message": "status code error !200"};
          break;
        case "error":
          res = {"message": "some server error occured!!"};
          break;
        case "noNetwork":
          res = {"message": "No internet !"};
          break;
        default:
      }
    isDeleteLoading = false;
notifyListeners();
      return res;
    }
  }

  //// editTask

  editTask(Task task) {
    employeeCode = task.empCode;

    selectedDate = task.deadLine;
    employeeName = task.name;
    editTasks = task.task;
    notifyListeners();
  }
}
