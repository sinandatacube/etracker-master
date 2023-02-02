import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../services/api/api_services.dart';

class ExpenseController extends ChangeNotifier {
  bool isloading = false;

  init() {
    isloading = false;
  }

  loadingState() {
    isloading = !isloading;
    notifyListeners();
  }

  setPaid(
    String id,
  ) async {
    loadingState();

    var result = await ApiServices().updatePaidExpense(id);
    log(result.toString());
    return result;
  }
}
