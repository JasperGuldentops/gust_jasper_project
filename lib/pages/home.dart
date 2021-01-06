import 'package:flutter/material.dart';
import 'package:gust_jasper_project/pages/arcrypto.dart';
import 'package:gust_jasper_project/pages/bill_list.dart';

import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State {
  List<String> features = ["image_tracking"];

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
      body: Center(
        child: RaisedButton(
            onPressed: navigateToAR, child: Text("Scan de coins!")),
      ),
    );
  }

  void navigateToAR() {
    debugPrint("Wij gaan naar dino's");

    this.checkDeviceCompatibility().then((value) => {
          if (value.success)
            {
              this.requestARPermissions().then((value) => {
                    if (value.success)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ARCryptoPage()),
                        )
                      }
                    else
                      {
                        debugPrint("AR permissions denied"),
                        debugPrint(value.message)
                      }
                  })
            }
          else
            {debugPrint("Device incompatible"), debugPrint(value.message)}
        });
  }

  void _navigateList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BillListPage()),
    );
  }

  Future<WikitudeResponse> checkDeviceCompatibility() async {
    return await WikitudePlugin.isDeviceSupporting(this.features);
  }

  Future<WikitudeResponse> requestARPermissions() async {
    return await WikitudePlugin.requestARPermissions(this.features);
  }
}
