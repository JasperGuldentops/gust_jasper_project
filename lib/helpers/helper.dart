import 'package:intl/intl.dart';

class Helper {
  static double numberToDouble(dynamic value) {
    if (value is int) {
      return double.parse(value.toString() + '.0');
    } else if (value is double) {
      return double.parse(value.toStringAsFixed(2));
    }
    return 0.00;
  }

  static String doubleToString(double price) {
    return price.toStringAsFixed(4).replaceAll('.', ',') + " \$";
  }

  static String dateToString(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy, HH:mm:ss');
    return formatter.format(date);
  }
}
