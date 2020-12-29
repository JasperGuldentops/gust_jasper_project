import 'package:flutter/material.dart';
import 'package:gust_jasper_project/pages/bill_list.dart';

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
        color: Colors.pink,
        child: Center(
          child: ElevatedButton(
            child: Text('Open route'),
            onPressed: () {
              _navigateList();
            },
          ),
        ),
      ),
    );
  }

  void _navigateList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BillListPage()),
    );
  }
}
