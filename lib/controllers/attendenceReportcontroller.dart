import 'dart:developer';

import 'package:employee_manage/models/attendenceReportModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/api/api_services.dart';

class AttendendceReportController extends ChangeNotifier {
  bool isLoading = false;
  String year = "";
  String month = "";
  String monthName = "";
  var finalDate;
  List data = [];
//init
  init() {
    isLoading = false;
    year = "";
    month = "";
    monthName = "";

    data = [];
  }

  getMonthAndYear(var selected) async {
    List date = selected.toString().split("-");
    year = date[0];
    month = date[1];
    finalDate = date[0] + "-" + date[1];
    checkMonth(month);
    notifyListeners();
  }

  //loading state controller
  loadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }

//get report from api
  onGet() async {
    if (finalDate == null) {
      Fluttertoast.showToast(msg: "Please select date");
    } else {
      loadingState();
      data.clear();
      log(data.toString(), name: "data");

      var res = await ApiServices().getAllAttendenceReport(finalDate);
      log(res.toString(), name: "res");

      if (res != '!200' && res != "error" && res != "noNetwork") {
        // var result = res;
        // log(result.toString());

        var result = AllAttendenceReportModel.fromJson(res);
        log(result.toString(), name: "body1");
        data = result.data;
        loadingState();
      } else {
        log(res);
        loadingState();
      }
    }
    notifyListeners();
  }

//check month by giving number
  checkMonth(String number) {
    if (month == "01") {
      monthName = "January";
    } else if (month == "02") {
      monthName = "February";
    } else if (month == "03") {
      monthName = "March";
    } else if (month == "04") {
      monthName = "April";
    } else if (month == "05") {
      monthName = "May";
    } else if (month == "06") {
      monthName = "June";
    } else if (month == "07") {
      monthName = "July";
    } else if (month == "08") {
      monthName = "August";
    } else if (month == "09") {
      monthName = "Septrmber";
    } else if (month == "10") {
      monthName = "October";
    } else if (month == "11") {
      monthName = "November";
    } else {
      monthName = "December";
    }
  }
}
