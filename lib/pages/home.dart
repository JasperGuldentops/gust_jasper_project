import 'package:flutter/material.dart';
import 'package:gust_jasper_project/apis/currency_api.dart';
import 'package:gust_jasper_project/helpers/helper.dart';
import 'package:gust_jasper_project/models/cryptocurrency.dart';
import 'package:gust_jasper_project/pages/arcrypto.dart';
import 'package:gust_jasper_project/pages/currency_detail.dart';

import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State {
  List<String> features = ["image_tracking"];
  List<CryptoCurrency> currencies = List<CryptoCurrency>();
  int count = 0;
  @override
  void initState() {
    super.initState();
    // load currencies on init
    _getCurrencies();
  }

  void _getCurrencies() {
    //get currencies
    CryptoCurrencyApi.fetchCurrencies().then((result) {
      setState(() {
        currencies = result;
        count = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CryptoChecker"),
        centerTitle: true,
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
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: _currencyListItems(),
          ),
        ),
      ),
    );
  }

  ListView _currencyListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            //Circular icon with first letter of cryptocurrency
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              child: Text(
                  this.currencies[position].name.substring(0, 1).toUpperCase()),
            ),
            title: Text(this.currencies[position].name),
            subtitle: Text(
                //This will transform price from double to string with dollar sign
                "Price " +
                    Helper.doubleToString(this.currencies[position].price)),
            onTap: () {
              //Show more info about selected Cryptocurrency
              _navigateToDetail(this.currencies[position].id);
            },
          ),
        );
      },
    );
  }

  void _navigateToDetail(String id) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrencyDetailPage(id)),
    );
    if (result == true) {
      _getCurrencies();
    }
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
