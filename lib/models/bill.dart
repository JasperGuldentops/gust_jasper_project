class Bill {
  int id;
  DateTime date;
  String shopName;
  String billTo;

  Bill({this.id, this.date, this.shopName, this.billTo});

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      date: json['date'],
      shopName: json['shop'],
      billTo: json['billTo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'shop': shopName,
        'billTo': billTo,
      };
}
