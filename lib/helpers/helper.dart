class Helper {
  static double numberToDouble(dynamic value) {
    if (value is int) {
      return double.parse(value.toString() + '.0');
    } else if (value is double) {
      return double.parse(value.toStringAsFixed(2));
    }
    return 0.00;
  }
}
