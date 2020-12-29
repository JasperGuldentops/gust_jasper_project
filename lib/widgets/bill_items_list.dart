import 'package:flutter/material.dart';
import 'package:gust_jasper_project/models/bill_item.dart';

//typedef void MyCallback(Currency currency);

class BillItemListWidget extends StatelessWidget {
  final List<BillItem> billItems;
  //final MyCallback onCurrencySelected;

  BillItemListWidget({this.billItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: billItems.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(this.billItems[position].product),
              subtitle: Text(this.billItems[position].price.toString() + " €"),
            ),
          );
        },
      ),
    );
  }
}
