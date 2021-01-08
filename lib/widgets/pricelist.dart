import 'package:flutter/material.dart';
import 'package:gust_jasper_project/helpers/helper.dart';
import 'package:gust_jasper_project/models/cryptocurrency.dart';

class PriceListWidget extends StatelessWidget {
  final CryptoCurrency currency;

  PriceListWidget({this.currency});

  @override
  Widget build(BuildContext context) {
    if (currency.prices.isEmpty) {
      return Text("No recorded history");
    }
    currency.prices.sort((a, b) {
      var adate = a.date;
      var bdate = b.date;
      return bdate.compareTo(adate);
    });
    return SizedBox(
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.resolveWith<Color>((states) => Colors.blue),
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Price'),
          ),
          DataColumn(
            label: Text('Date'),
          ),
        ],
        rows: List<DataRow>.generate(
          currency.prices.length, //The amount of rows to generate
          (index) => DataRow(
            color: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              // Set even rows to gray color
              if (index % 2 == 0) return Colors.grey.withOpacity(0.3);
              return null; // Set non even rows to default color
            }),
            cells: [
              DataCell(
                Container(
                  width: 100,
                  child:
                      Text(Helper.doubleToString(currency.prices[index].price)),
                ),
              ),
              DataCell(
                Text(Helper.dateToString(currency.prices[index].date)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
