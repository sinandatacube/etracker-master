import 'package:employee_manage/controllers/authcontroller.dart';
import 'package:employee_manage/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final idCntr = TextEditingController();
  final pswCntr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset('assets/images/logo.png',
    height: 240,
    );
    // Hero(
    //   tag: 'hero',
    //   child: CircleAvatar(
    //     backgroundColor: Colors.white,
    //     radius: 36.0,
    //     child: Image.asset('assets/images/logo.png'),
    //   ),
    // );

    const appLogo = Text(
      'ETRACKER',
      style: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    );

    return Scaffold(
      backgroundColor:  Colors.white,//Color.fromARGB(255, 226, 213, 253), // Color.fromARGB(218, 163, 95, 177), //rgb(167, 0, 255)
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              // color: Color.fromARGB(255, 237, 188, 253),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               
                  logo,
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // appLogo,
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [Container()]),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              height: sH(context)/2,
              margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              // margin: EdgeInsets.symmetric(horizontal: 32),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  // BorderRadius.only(
                  //     topLeft: Radius.circular(100),
                  //     bottomRight: Radius.circular(100)
                  //     ),
                  color: Colors.white,  // Color.fromARGB(255, 226, 213, 253),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2
                    )
                  ]
                  ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      spaceHeight(20),
                      const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      spaceHeight(20),
                      spaceHeight(8),
                      Material(
                        elevation: 10.0,
                        shadowColor: Colors.grey,
                        child: TextFormField(
                          controller: idCntr,
                          autofocus: false,
                          decoration: InputDecoration(
                              //  icon: new Icon(Icons., color: Color(0xff224597)),
                              suffixIcon: const Icon(
                                Icons.person,
                              ),
                              hintText: 'Emp id',
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 3.0))),
                        ),
                      ),
                      spaceHeight(25),
                      Material(
                        elevation: 10.0,
                        shadowColor: Colors.grey,
                        child: TextFormField(
                          controller: pswCntr,
                          autofocus: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            //  icon: new Icon(Icons., color: Color(0xff224597)),
                            suffixIcon: const Icon(
                              Icons.lock,
                            ),
                            hintText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 3.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceHeight(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (idCntr.text.isNotEmpty &&
                              pswCntr.text.isNotEmpty) {
                            await context
                                .read<AuthController>()
                                .checkLogin(
                                    id: idCntr.text.trim(),
                                    psw: pswCntr.text.trim())
                                .then((val) => val == 1
                                    ? navigatorKey.currentState!
                                        .pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ),
                                      )
                                    : Fluttertoast.showToast(
                                        msg: "password/id mismatch !!"));
                            ;
                          } else {
                            Fluttertoast.showToast(
                                msg: "All fields are required !!");
                          }
                          // userLogin(_empidController.text, _passwordController.text);
                          // Navigator.of(context).pushReplacementNamed(Home.tag);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:const Color.fromARGB(255, 201, 33, 243),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: const Size(100, 40),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      spaceWidth(10),
                    ],
                  ),
                  spaceHeight(50),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [

                  // TextButton(onPressed: (){

                  // }, child:const Text(
                  //       "Forgot Password",
                  //       textAlign: TextAlign.end,
                  //       style: TextStyle(
                  //         decoration: TextDecoration.underline,
                  //         decorationStyle: TextDecorationStyle.solid,
                  //         decorationThickness: 2,
                  //           color:Colors.grey,
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.w600),
                  //     ),),

                  // spaceWidth(30),
                  //     InkWell(
                  //       child:const Text(
                  //         "Sign up ?",
                  //         textAlign: TextAlign.end,
                  //         style: TextStyle(
                  //             color: Colors.blue,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //       onTap: () {
                  //         // Navigator.of(context)
                  //         //   .pushNamed(ConfigGlobal.register);
                  //       },
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),

            // taleLogin,
          ],
        ),
      ),
    );
  }
}
