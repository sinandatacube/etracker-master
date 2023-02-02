// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class ViewTask extends StatelessWidget {
//   const ViewTask({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:const Text("Task"),
//       ),
//       body: FutureBuilder(
//         future: context.read<HomeController>().getTasks(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.data == "!200") {
//               return const Center(
//                 child: Text("!200"),
//               );
//             } else if (snapshot.data == "error") {
//               return const Center(
//                 child: Text("error"),
//               );
//             } else if (snapshot.data == "noNetwork") {
//               return const Center(
//                 child: Text("nonetwork"),
//               );
//             } else {
//               return body(context, context.read<HomeController>());
//             }
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }