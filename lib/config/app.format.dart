import 'package:intl/intl.dart';

class Appformat {
  static String date(String stringDate){
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM yyyy', 'id_ID').format(dateTime);
  }
  
}