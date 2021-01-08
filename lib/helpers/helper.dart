class Helper {
  static double numberToDouble(dynamic value) {
    if (value is int) {
      return double.parse(value.toString() + '.0');
    } else if (value is double) {
      return double.parse(value.toString());
    }
    return 0.00;
  }

  static String doubleToPriceString(double price) {
    return "Price: " + price.toStringAsFixed(4).replaceAll('.', ',') + " \$";
  }
  static String doubleToFullPriceString(double price) {
    return "Price: " + price.toString().replaceAll('.', ',') + " \$";
  }
}
