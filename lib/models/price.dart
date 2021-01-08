import 'package:gust_jasper_project/helpers/helper.dart';

class Price {
  int id;
  String cryptocurrencyId;
  double price;
  DateTime date;

  Price({this.id, this.cryptocurrencyId, this.price, this.date});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'],
      cryptocurrencyId: json['cryptocurrencyId'],
      price: Helper.numberToDouble(json['price']),
      date: DateTime.parse((json['date'])),
    );
  }

  Map<String, dynamic> toJson() => {
        'cryptocurrencyId': cryptocurrencyId,
        'price': price,
        'date': date,
      };
}
