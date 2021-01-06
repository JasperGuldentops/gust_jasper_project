class CryptoCurrency {
  int id;
  String name;
  double price;
  double amount;
  String webUrl;

  CryptoCurrency({this.id, this.name, this.price, this.amount, this.webUrl});

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      amount: json['amount'],
      webUrl: json['webUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'amount': amount,
        'webUrl': webUrl,
      };
}
