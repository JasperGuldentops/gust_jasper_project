import 'package:flutter/material.dart';
import 'package:gust_jasper_project/apis/bill_api.dart';
import 'package:gust_jasper_project/models/bill.dart';
import 'package:gust_jasper_project/models/bill_item.dart';

final List<String> choices = const <String>['Save', 'Delete'];

class BillDetailPage extends StatefulWidget {
  final int id; // id of Bill to show
  BillDetailPage(this.id);

  @override
  State<StatefulWidget> createState() => _BillDetailPageState(id);
}

class _BillDetailPageState extends State {
  int id; // id of Bill to show
  _BillDetailPageState(this.id);

  Bill bill; //the bill that we will be showing

  // we will use this page to update the user info as well, therefore we use TextEditingController's
  TextEditingController shopNameController = TextEditingController();
  TextEditingController billToController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (id == null) {
      bill = new Bill(date: null, shopName: "", billTo: "");
    } else {
      _getBill(id);
    }
  }

  void _getBill(int id) {
    BillApi.fetchBill(id).then((result) {
      // call the api to fetch the user data
      setState(() {
        bill = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User details"),
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
        child: _billDetails(),
      ),
    );
  }

  _billDetails() {
    if (bill == null) {
      // show a ProgressIndicator as long as there's no bill info
      return Center(child: CircularProgressIndicator());
    } else {
      TextStyle textStyle = Theme.of(context).textTheme.bodyText1;

      //Set values of controllers
      shopNameController.text = bill.shopName;
      billToController.text = bill.billTo;

      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: shopNameController,
              style: textStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Shop name",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            TextField(
              controller: billToController,
              style: textStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Bill To",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            Container(
              height: 10,
              padding: EdgeInsets.all(5.0),
              child: _billItemsList(bill),
            ),
          ],
        ),
      );
    }
  }

  SizedBox _billItemsList(Bill bill) {
    return SizedBox.expand(
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.resolveWith<Color>((states) => Colors.blue),
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Product'),
          ),
          DataColumn(
            label: Text('Price in €'),
          ),
        ],
        rows: List<DataRow>.generate(
          bill.billItems.length, //The amount of rows to generate
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
                  child: Text(bill.billItems[index].product),
                ),
              ),
              DataCell(
                Text(_getProductPrice(bill.billItems[index])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getProductPrice(BillItem billItem) {
    return billItem.price.toString().replaceAll('.', ',');
  }

  void _menuSelected(String index) async {
    switch (index) {
      case "0": // Save Bill
        _saveBill();
        break;
      case "1": // Delete Bill
        _deleteBill();
        break;
      default:
    }
  }

  void _saveBill() {
    bill.shopName = shopNameController.text;
    bill.billTo = billToController.text;

    if (bill.id == null) {
      BillApi.createBill(bill).then((result) {
        Navigator.pop(context, true);
      });
    } else {
      BillApi.updateBill(id, bill).then((result) {
        Navigator.pop(context, true);
      });
    }
  }

  void _deleteBill() {
    BillApi.deleteBill(id).then((result) {
      Navigator.pop(context, true);
    });
  }
}
