import 'package:flutter/material.dart';

sW(context) => MediaQuery.of(context).size.width;
sH(context) => MediaQuery.of(context).size.height;
spaceHeight(h) => SizedBox(
      height: h.toDouble(),
    );
spaceWidth(w) => SizedBox(
      width: w.toDouble(),
    );


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


