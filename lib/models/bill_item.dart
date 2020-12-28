class BillItem {
  int id;
  int billID;
  String product;
  double price;

  BillItem({this.id, this.billID, this.product, this.price});

  factory BillItem.fromJson(Map<String, dynamic> json) {
    return BillItem(
      id: json['id'],
      billID: json['billId'],
      product: json['product'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() => {
        'billId': billID,
        'product': product,
        'price': price,
      };
}
