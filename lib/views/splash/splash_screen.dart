import 'dart:async';
import 'dart:developer';

import 'package:employee_manage/controllers/authcontroller.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/auth/login_screen.dart';
import 'package:employee_manage/views/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      var k = await context.read<AuthController>().isCredtional();
      log(k.toString(), name: "islogin");

      k
          ? navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ))
          : navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: SizedBox()),
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
       
         const CupertinoActivityIndicator(
            color: Color.fromARGB(255, 201, 33, 243),
            radius: 10,
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
