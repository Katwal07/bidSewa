import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime{
  String toFormattedString(DateTime date){
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }
}