import 'package:gust_jasper_project/models/cryptocurrency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoCurrencyApi {
  static String url = 'https://tough-dolphin-7.loca.lt';
  //static String url = 'http://localhost:3000';

  static Future<List<CryptoCurrency>> fetchCurrencies() async {
    final response = await http.get(url + '/cryptocurrencies');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((currency) => new CryptoCurrency.fromJson(currency))
          .toList();
    } else {
      throw Exception('Currencies loaing failed!');
    }
  }

  static Future<CryptoCurrency> fetchCurrency(String id) async {
    final response = await http.get(url + '/cryptocurrencies/' + id);
    if (response.statusCode == 200) {
      return CryptoCurrency.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Currency loading failed!');
    }
  }

  static Future<CryptoCurrency> createCurrency(CryptoCurrency currency) async {
    final http.Response response = await http.post(
      url + '/cryptocurrencies',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(currency),
    );
    if (response.statusCode == 201) {
      return CryptoCurrency.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Currency creation failed!');
    }
  }

  static Future<CryptoCurrency> updateCurrency(
      String id, CryptoCurrency currency) async {
    final http.Response response = await http.put(
      url + '/cryptocurrencies/' + id,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(currency),
    );
    if (response.statusCode == 200) {
      return CryptoCurrency.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Currency update failed!');
    }
  }

  static Future deleteCurrency(String id) async {
    final http.Response response =
        await http.delete(url + '/cryptocurrencies/' + id);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Currency deletion failed!');
    }
  }
}
