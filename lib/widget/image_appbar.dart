import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

AppBar imageAppBar() => AppBar(
    title: Center(child:
    Image.asset(
      "assets/images/logo_full.png",
      fit: BoxFit.contain,
      height: 24,
    )
    ),
    backgroundColor: Colors.transparent
);
