import 'package:flutter/material.dart';
import 'package:gust_jasper_project/apis/bill_api.dart';
import 'package:gust_jasper_project/models/bill.dart';
import 'package:gust_jasper_project/models/bill_item.dart';
import 'package:gust_jasper_project/pages/bill_detail.dart';

class BillListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BillListPageState();
}

class _BillListPageState extends State {
  List<Bill> bills = List<Bill>();
  int count = 0;

  @override
  void initState() {
    super.initState();
    // load bills on init
    _getBills();
  }

  void _getBills() {
    //get bills from API
    BillApi.fetchBills().then((result) {
      setState(() {
        bills = result;
        count = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bills"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToScan();
        },
        tooltip: "Scan new bill",
        child: new Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: _billListItems(),
      ),
    );
  }

  ListView _billListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              child: Text(this.bills[position].shopName.substring(0, 1)),
            ),
            title: Text(
                this.bills[position].billItems.length.toString() + " items"),
            subtitle: Text(_totalText(this.bills[position]) +
                _billToText(this.bills[position])),
            onTap: () {
              _navigateToDetail(this.bills[position].id);
            },
          ),
        );
      },
    );
  }

  void _navigateToDetail(int id) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BillDetailPage(id)),
    );
    if (result == true) {
      _getBills();
    }
  }

  void _navigateToScan() {
    //Navigate to wikitude nonsense
  }

  String _totalText(Bill bill) {
    double total = 0;

    for (BillItem billItem in bill.billItems) {
      total += billItem.price;
    }
    return total.toString().replaceAll('.', ',') + " €";
  }

  String _billToText(Bill bill) {
    String message = "";

    if (bill.billTo != null && bill.billTo.isNotEmpty) {
      message = " - (" + bill.billTo + ")";
    }
    return message;
  }
}
