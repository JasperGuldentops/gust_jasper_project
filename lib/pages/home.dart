import 'package:flutter/material.dart';
import 'package:gust_jasper_project/pages/currency_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title in App Bar"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToScan();
        },
        tooltip: "Scan for crypto currency",
        child: new Icon(Icons.camera_alt),
      ),
      body: new Material(
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            child: Text('All crypto currencies'),
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
      MaterialPageRoute(builder: (context) => CurrencyListPage()),
    );
  }

  void _navigateToScan() {
    //Navigate to wikitude nonsense
  }
}
