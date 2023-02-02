import 'dart:developer';

import 'package:employee_manage/models/notificationmodel.dart';
import 'package:employee_manage/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';

class NotificationController extends ChangeNotifier {
  List<NotificationModel> notifications = [];

  bool isLoading = false;
  bool isDelete = false;
  createNotification({required title, required description}) async {
    isLoading = true;
    notifyListeners();
    var res = await ApiServices().createNotification(
        title: title,
        description: description,
        date: DateTime.now().toString());
    log(res.toString());
    if (res != '!200' && res != "error" && res != "noNetwork") {
      if (res['success'] == 1) {
        isLoading = false;
        notifyListeners();
        return {"message": "Notification added successfully"};
      } else {
        isLoading = false;
        notifyListeners();
        return {"message": res['message']};
      }
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
      isLoading = false;
      notifyListeners();
      return res;
    }
  }

  //// fetch

  fetchNotifications() async {
    notifications = [];
    var res = await ApiServices().fetchNotification();

    if (res != '!200' && res != "error" && res != "noNetwork") {
      if (res["success"] == 1) {
        var result = AllNotifications.fromJson(res);
        notifications = result.notifications;
        notifyListeners();
        return "ok";
      } else {
        return res['message'];
      }
    } else {
      log(res);
      return res;
    }
  }

  /// delete

  deleteNotification({required id}) async {
    isDelete = true;
    notifyListeners();
    var res = await ApiServices().deleteNotification(id: id);
    log(res.toString());
    if (res != '!200' && res != "error" && res != "noNetwork") {
      if (res['success'] == 1) {
        notifications.removeWhere((element) => element.id == id);
        isDelete = false;

        notifyListeners();
        return {"message": "Notification deleted successfully"};
      } else {
        isDelete = true;
        notifyListeners();
        return {"message": res['message']};
      }
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
      isDelete = true;
      notifyListeners();
      return res;
    }
  }
}
