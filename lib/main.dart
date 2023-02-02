import 'package:employee_manage/controllers/authcontroller.dart';
import 'package:employee_manage/controllers/employeecontroller.dart';
import 'package:employee_manage/controllers/expensecontroller.dart';
import 'package:employee_manage/controllers/homecontroller.dart';
import 'package:employee_manage/controllers/leavecontroller.dart';
import 'package:employee_manage/controllers/notificationcontroller.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

import 'controllers/attendenceReportcontroller.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AttendendceReportController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => EmployeeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LeaveController(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpenseController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        localizationsDelegates: [
          MonthYearPickerLocalizations.delegate,
        ],
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
