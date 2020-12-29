import 'package:gust_jasper_project/models/bill.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BillApi {
  static String url = 'https://wicked-panda-94.loca.lt';
  //static String url = 'http://localhost:3000';

  static Future<List<Bill>> fetchBills() async {
    final response = await http.get(url + '/bills?_embed=billItems');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((bill) => new Bill.fromJson(bill)).toList();
    } else {
      throw Exception('Bills loaing failed!');
    }
  }

  static Future<Bill> fetchBill(int id) async {
    final response =
        await http.get(url + '/bills/' + id.toString() + '?_embed=billItems');
    if (response.statusCode == 200) {
      return Bill.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Bill loading failed!');
    }
  }

  static Future<Bill> createBill(Bill bill) async {
    final http.Response response = await http.post(
      url + '/bills',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(bill),
    );
    if (response.statusCode == 201) {
      return Bill.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Bill creation failed!');
    }
  }

  static Future<Bill> updateBill(int id, Bill bill) async {
    final http.Response response = await http.put(
      url + '/bills/' + id.toString() + '?_embed=billItems',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(bill),
    );
    if (response.statusCode == 200) {
      return Bill.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Bill update failed!');
    }
  }

  static Future deleteBill(int id) async {
    final http.Response response =
        await http.delete(url + '/bills/' + id.toString());
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Bill deletion failed!');
    }
  }
}
