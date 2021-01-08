import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gust_jasper_project/apis/currency_api.dart';
import 'package:gust_jasper_project/helpers/helper.dart';
import 'package:gust_jasper_project/models/cryptocurrency.dart';
import 'package:gust_jasper_project/extensions/string_extension.dart';
import 'package:gust_jasper_project/pages/arcrypto.dart';
import 'package:gust_jasper_project/widgets/pricelist.dart';
import 'package:url_launcher/url_launcher.dart';

//Options to show in top menu
final List<String> choices = const <String>['Delete'];

class CurrencyDetailPage extends StatefulWidget {
  final String id; // id of Currency to show
  CurrencyDetailPage(this.id);

  @override
  State<StatefulWidget> createState() => _CurrencyDetailPageState(id);
}

class _CurrencyDetailPageState extends State {
  List<String> features = ["image_tracking"];
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
          //Show currencyname once loading is done
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
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToScan();
        },
        tooltip: "Scan for crypto currency",
        child: new Icon(Icons.camera_alt),
      ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: _currencyDetails(),
            ),
          ),
        ));
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
  Future<WikitudeResponse> checkDeviceCompatibility() async {
    return await WikitudePlugin.isDeviceSupporting(this.features);
  }

  Future<WikitudeResponse> requestARPermissions() async {
    return await WikitudePlugin.requestARPermissions(this.features);
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
              "Worth: " + Helper.doubleToString(currency.price*currency.amount),
              style: TextStyle(
                fontSize: 20.0,
                decoration: TextDecoration.none,
              ),
            ),
            Container(
              height: 15,
            ),
            //Richtext area to hold textspans showing the website and website url
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
            //Horizontal line divider to seperate owned cryptocurrency
            const Divider(
              color: Colors.black,
              height: 50,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Container(
              width: 265,
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: TextField(
                      controller: amountController,
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      //Only allow digits and . to be used to prevent strings
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
                  Container(
                    width: 15,
                  ),
                  Container(
                    width: 100,
                    child: RaisedButton(
                      onPressed: () {
                        _saveCurrency();
                      },
                      color: Colors.blue,
                      child: const Text('Save',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
            ),
            PriceListWidget(currency: currency)
          ],
        ),
      );
    }
  }

  //Top menu actions
  void _menuSelected(String index) async {
    switch (index) {
      case "0": // Delete currency
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
