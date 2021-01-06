import 'package:flutter/material.dart';
import 'package:gust_jasper_project/apis/currency_api.dart';
import 'package:gust_jasper_project/models/cryptocurrency.dart';
import 'package:gust_jasper_project/pages/currency_detail.dart';

class CurrencyListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CurrencyListPageState();
}

class _CurrencyListPageState extends State {
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
        title: Text("Crypto Currencies"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToScan();
        },
        tooltip: "Scan for crypto currency",
        child: new Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: _currencyListItems(),
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
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              child: Text(this.currencies[position].name.substring(0, 1)),
            ),
            title: Text(this.currencies[position].name),
            subtitle: Text(_priceText(this.currencies[position])),
            onTap: () {
              _navigateToDetail(this.currencies[position].id);
            },
          ),
        );
      },
    );
  }

  void _navigateToDetail(int id) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrencyDetailPage(id)),
    );
    if (result == true) {
      _getCurrencies();
    }
  }

  void _navigateToScan() {
    //Navigate to wikitude nonsense
  }

  String _priceText(CryptoCurrency currency) {
    return "Price: " + currency.price.toString().replaceAll('.', ',') + " €";
  }
}
