import 'dart:developer';

import 'package:employee_manage/models/leavesmodel.dart';
import 'package:employee_manage/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';

class LeaveController extends ChangeNotifier {
  List<Leaves> newleaves = [];
  List<Leaves> rejectedleaves = [];
  List<Leaves> acceptedleaves = [];

  int seletedTabIndex = 0;

  

  setIndex(val) {
    seletedTabIndex = val;
    notifyListeners();
  }

  fetchAllLeaves() async {
    var res = await ApiServices().getAllLeaves();
    log(res.toString());
    if (res != '!200' && res != "error" && res != "noNetwork") {
      var result = AllLeaves.fromJson(res);
      var newL = result.leaves.where((e) => e.status == "0").toList();
      var rL = result.leaves.where((e) => e.status == "-1").toList();
      var aL = result.leaves.where((e) => e.status == "1").toList();
      newleaves = newL;
      rejectedleaves = rL;
      acceptedleaves = aL;
      log(newleaves.toString());
      log(rejectedleaves.toString());
      log(acceptedleaves.toString());

      notifyListeners();

      return result;
    } else {
      log(res);
      return res;
    }
  }

//// updateLeave

  updateLeave({required id, required status, required Leaves datas}) async {
    var res = await ApiServices().updateLeave(id: id, status: status);
    if (res != '!200' && res != "error" && res != "noNetwork") {
      if (status == 1) {
        newleaves.removeWhere((element) => element.id == id);
        var leave = Leaves(
            id: id,
            empcode: datas.empcode,
            name: datas.name,
            date: datas.date,
            reason: datas.reason,
            leaveDate: datas.leaveDate,
            status: "1");
        acceptedleaves.add(leave);
      } else {
        newleaves.removeWhere((element) => element.id == id);
        newleaves.removeWhere((element) => element.id == id);
        var leave = Leaves(
            id: id,
            empcode: datas.empcode,
            name: datas.name,
            date: datas.date,
            reason: datas.reason,
            leaveDate: datas.leaveDate,
            status: "-1");
        rejectedleaves.add(leave);
      }
      var result = "ok";
      notifyListeners();
      return result;
    } else {
      log(res);
      return res;
    }
  }
}
