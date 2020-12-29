import 'package:gust_jasper_project/models/bill_item.dart';

class Bill {
  int id;
  DateTime date;
  String shopName;
  String billTo;
  List<BillItem> billItems;

  Bill({this.id, this.date, this.shopName, this.billTo, this.billItems});

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      date: json['date'],
      shopName: json['shop'],
      billTo: json['billTo'],
      billItems: json['billItems'] == null
          ? null
          : List<BillItem>.from(
              json['billItems'].map((x) => BillItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'shop': shopName,
        'billTo': billTo,
      };
}
