import 'package:intl/intl.dart';

dateTimeToString(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}
