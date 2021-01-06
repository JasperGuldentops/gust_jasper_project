import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gust_jasper_project/apis/currency_api.dart';
import 'package:gust_jasper_project/helpers/helper.dart';
import 'package:gust_jasper_project/models/cryptocurrency.dart';
import 'package:gust_jasper_project/extensions/string_extension.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> choices = const <String>['Save', 'Delete'];

class CurrencyDetailPage extends StatefulWidget {
  final String id; // id of Currency to show
  CurrencyDetailPage(this.id);

  @override
  State<StatefulWidget> createState() => _CurrencyDetailPageState(id);
}

class _CurrencyDetailPageState extends State {
  String id; // id of currency to show
  _CurrencyDetailPageState(this.id);

  CryptoCurrency currency; //the currency about which we show details

  // TextEditingControllers for updating the value of amount
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (id == null) {
      currency =
          new CryptoCurrency(name: "", price: 0.0, amount: 0.0, webUrl: "");
    } else {
      _getCurrency(id);
    }
  }

  void _getCurrency(String id) {
    CryptoCurrencyApi.fetchCurrency(id).then((result) {
      // call the api to fetch the currency data
      setState(() {
        currency = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currency == null
            ? 'loading'
            : currency.name.capitalize() + " details"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _menuSelected,
            itemBuilder: (BuildContext context) {
              return choices.asMap().entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.key.toString(),
                  child: Text(entry.value),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: _currencyDetails(),
      ),
    );
  }

  _currencyDetails() {
    if (currency == null) {
      // show a ProgressIndicator until currency is loaded
      return Center(child: CircularProgressIndicator());
    } else {
      TextStyle textStyle = Theme.of(context).textTheme.bodyText1;

      //Set values of controller
      amountController.text = currency.amount.toString();

      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              //Show the price
              Helper.doubleToPriceString(currency.price),
              style: TextStyle(
                fontSize: 20.0,
                decoration: TextDecoration.none,
              ),
            ),
            Container(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                //Holds both website and URL text
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Website: ",
                  ),
                  TextSpan(
                    text: currency.webUrl, //Set text to URL
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = currency.webUrl; //URL that will be linked
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceSafariVC: false,
                          );
                        }
                      },
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 50,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Container(
              width: 200,
              child: TextField(
                controller: amountController,
                style: textStyle,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r"^\d*\.?\d*"),
                  )
                ],
                decoration: InputDecoration(
                  labelText: "Owned " + currency.name,
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _menuSelected(String index) async {
    switch (index) {
      case "0": // Save currency
        _saveCurrency();
        break;
      case "1": // Delete currency
        _deleteCurrency();
        break;
      default:
    }
  }

  void _saveCurrency() {
    currency.amount = double.parse(amountController.text);

    if (currency.id == null) {
      //if no id is available make new currency
      CryptoCurrencyApi.createCurrency(currency).then((result) {
        Navigator.pop(context, true);
      });
    } else {
      //with id update the selected currency
      CryptoCurrencyApi.updateCurrency(id, currency).then((result) {
        Navigator.pop(context, true);
      });
    }
  }

  void _deleteCurrency() {
    CryptoCurrencyApi.deleteCurrency(id).then((result) {
      Navigator.pop(context, true);
    });
  }
}
