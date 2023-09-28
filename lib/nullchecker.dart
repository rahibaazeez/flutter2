import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nullcheck extends StatefulWidget {
  const Nullcheck({Key? key}) : super(key: key);

  @override
  State<Nullcheck> createState() => _NullcheckState();
}

class _NullcheckState extends State<Nullcheck> {
  String? a;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(a?.length.toString() ?? "iuiyuu"),

    );
  }
}
