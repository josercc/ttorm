import 'package:flutter/material.dart';
import 'package:ttorm/ttorm_identifier.dart';
import 'package:ttorm/ttorm_navigator.dart';

class APage extends StatefulWidget {
  final String name;
  APage({Key? key, required this.name}) : super(key: key);

  @override
  _APageState createState() => _APageState();
}

class _APageState extends State<APage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.name),
            TextButton(
              onPressed: () => TtormNavigator.push(TtormIdentifier("APage"), context),
              child: Text("跳转到FlutterB"),
            ),
            TextButton(
              onPressed: () => TtormNavigator.push(TtormIdentifier("AViewController"), context),
              child: Text("跳转到NativeA"),
            ),
          ],
        ),
      ),
    );
  }
}
