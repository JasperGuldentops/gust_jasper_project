import 'package:flutter/material.dart';
import 'package:gust_jasper_project/pages/arcrypto.dart';
import 'package:gust_jasper_project/pages/currency_list.dart';
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

  void navigateToAR() {}

  void _navigateList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrencyListPage()),
    );
  }

  Future<WikitudeResponse> checkDeviceCompatibility() async {
    return await WikitudePlugin.isDeviceSupporting(this.features);
  }

  Future<WikitudeResponse> requestARPermissions() async {
    return await WikitudePlugin.requestARPermissions(this.features);
  }
    void _navigateToScan() {
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
  }

