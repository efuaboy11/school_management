import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';


Future<String> makePayement(BuildContext context, String email, String amount) async{
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
      print('success');
      Map<String, dynamic> data = json.decode(response.body);
      await  FlutterPaystackPlus.openPaystackPopup(
        customerEmail: email, 
        amount: amount, 
        reference: data['reference'], 
        context: context,
        onClosed: (){
          print('Payment closed or cancelled');
        }, 
        onSuccess: (){
          print('Payment successful!');
        }
      );

    }else{
      final errorData = jsonDecode(response.body);
      final errorMessages = errorData.values.join(", ");
      print("Login failed: ${response.statusCode}");
      print("Response body: ${response.body}");
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