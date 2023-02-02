import 'dart:developer';

import 'package:employee_manage/models/employeeAttendenceModel.dart';
import 'package:employee_manage/models/emptaskmodel.dart';
import 'package:employee_manage/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';

class EmployeeController extends ChangeNotifier {
  int seletedTabIndex = 0;
  List<EmployeeTaskModel> employeeTasks = [];
  List<EmployeeAttendenceModel> employeeAttendence = [];

  setIndex(val) {
    seletedTabIndex = val;
    notifyListeners();
  }

  fetchTasksEmp({required id}) async {
    employeeTasks = [];
    employeeAttendence = [];
    var res = await ApiServices().fetchTasksById(id: id);
    log(res.toString(), name: 'employee tasks');
    if (res != '!200' && res != "error" && res != "noNetwork") {
      var result = AllEmployeeTaskModel.fromJson(res);
      var attendenceResult = AllEmployeeAttendenceModel.fromJson(res);
      employeeAttendence = attendenceResult.data;
      employeeTasks = result.data;
      notifyListeners();
      return result;
    } else {
      log(res);
      return res;
    }
  }
}
