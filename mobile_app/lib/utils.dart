import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paystack_plus/src/paystack.dart';



Future<String> makePayement(BuildContext context, String email, String amount, Function onPaymentSuccessful) async{
  final token = await AuthService.getAccessToken(); 
  try{
    final response = await http.post(
      Uri.parse("http://school.amanilightequity.com/api/initialize-payment/"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({ // ✅ Encode the body as JSON
        'email': email,
        'amount': int.parse(double.parse(amount).toStringAsFixed(0)),

      }),
    
      
    );

    if(response.statusCode == 201 || response.statusCode == 200){

      Map<String, dynamic> data = json.decode(response.body);

      final secretKey = data['private_key'] as String;
      final publicKey = data['public_key'] as String;

      await FlutterPaystackPlus.openPaystackPopup(
            customerEmail: email,
            amount: (double.parse(amount) * 100).toInt().toString(),
            reference: 'TXN_${DateTime.now().millisecondsSinceEpoch}',
            secretKey: secretKey,
            publicKey: publicKey,
            currency: 'NGN',
            callBackUrl: 'http://school.amanilightequity.com/api/initialize-payment/',
            context: context,
            onClosed: () => onPaymentSuccessful(context),
            onSuccess: () => onPaymentSuccessful(context),
          );

    }else{
      final errorData = jsonDecode(response.body);
      final errorMessages = errorData.values.join(", ");
      return errorMessages;
    }
    

  }catch(e){
    print(e);

  }

  return '';

}



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