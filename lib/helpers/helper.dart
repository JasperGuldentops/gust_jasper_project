import 'package:flutter/material.dart';
import 'package:gust_jasper_project/models/cryptocurrency.dart';
import 'package:intl/intl.dart';

class Helper {
  static double numberToDouble(dynamic value) {
    if (value is int) {
      return double.parse(value.toString() + '.0');
    } else if (value is double) {
      return double.parse(value.toString());
    }
    return 0.00;
  }

  static String doubleToString(double price) {
    return price.toStringAsFixed(4).replaceAll('.', ',') + " \$";
  }

  static String dateToString(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy, HH:mm:ss');
    return formatter.format(date);
  }

  static Text getText(int i, CryptoCurrency currency) {
    String data = doubleToString(currency.prices[i].price);
    double priceNew = currency.prices[i].price;
    double priceOld;
    String symbol = " \u2194";
    TextStyle textStyle = TextStyle(color: Colors.blue);
    if (i + 1 < currency.prices.length) {
      priceOld = currency.prices[i + 1].price;
      if (priceNew > priceOld) {
        textStyle = TextStyle(color: Colors.green);
        symbol = " \u2B06 ";
      } else {
        if (priceNew < priceOld) {
          textStyle = TextStyle(color: Colors.red);
          symbol = " \u2B07";
        }
      }
    }

    return Text(data+symbol, style: textStyle);
  }
}
