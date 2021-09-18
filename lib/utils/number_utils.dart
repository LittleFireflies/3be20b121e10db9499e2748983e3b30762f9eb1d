import 'package:intl/intl.dart';

String currencyFormat(int number) {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'in_ID');

  return formatCurrency.format(number);
}
