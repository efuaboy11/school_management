import 'package:intl/intl.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:paystack/paystack.dart';
import 'package:http/http.dart' as http;


// Future<String> makePayement(String email, String amount) async{
//   final token = await AuthService.getAccessToken(); 
//   final Paystack paystack = Paystack();
//   try{
//     final response = await http.post(
//       Uri.parse("http://school.amanilightequity.com/api/initialize-payment/"),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: {
//         'email' : email,
//         'amount': amount,
//       }
      
//     );

//     if(response.statusCode == 201 || response.statusCode == 200){
//       await paystack.

//     }


//   }

// }




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


String formatMoney(String amount) {
  try {
    final parsed = int.parse(amount);
    final formatter = NumberFormat('#,###');
    return formatter.format(parsed);
  } catch (e) {
    return amount; // return original if parsing fails
  }
}