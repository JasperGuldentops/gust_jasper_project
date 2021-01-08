import 'package:gust_jasper_project/helpers/helper.dart';
import 'package:gust_jasper_project/models/price.dart';

class CryptoCurrency {
  String id;
  String name;
  double price;
  double amount;
  String webUrl;
  List<Price> prices;

  CryptoCurrency(
      {this.id, this.name, this.price, this.amount, this.webUrl, this.prices});

  factory CryptoCurrency.fromJsonWithoutPrices(Map<String, dynamic> json) {
    return CryptoCurrency(
      id: json['id'].toString(),
      name: json['name'],
      price: Helper.numberToDouble(json['price']),
      amount: Helper.numberToDouble(json['amount']),
      webUrl: json['webUrl'],
    );
  }

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      id: json['id'].toString(),
      name: json['name'],
      price: Helper.numberToDouble(json['price']),
      amount: Helper.numberToDouble(json['amount']),
      webUrl: json['webUrl'],
      prices: json['prices'] == null
          ? null
          : List<Price>.from(json['prices'].map((x) => Price.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'amount': amount,
        'webUrl': webUrl,
      };
}
