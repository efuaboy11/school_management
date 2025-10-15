import 'package:intl/intl.dart';


String formatName(String name) {
  // Example implementation: capitalize the first letter
  if (name.isEmpty) return name;
  return name[0].toUpperCase() + name.substring(1);
}

String formatDate(String date){
  final DateTime parsedDate = DateTime.parse(date);

  final formatter = DateFormat.yMMMMd();
  return formatter.format(parsedDate);
}