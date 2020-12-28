import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State {
  @override
  void initState() {
    super.initState();
    //_getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title in App Bar"),
      ),
      body: new Material(
        color: Colors.deepPurple,
        child: Center(
          child: new Text(
            sayHello(),
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.white, fontSize: 36.0),
          ),
        ),
      ),
    );
  }
}

String sayHello() {
  String hello;
  DateTime now = new DateTime.now();
  int hour = now.hour;

  if (hour < 12) {
    hello = "Good Morning";
  } else if (hour < 18) {
    hello = "Good Afternoon";
  } else {
    hello = "Good Evening";
  }

  return hello;
}
