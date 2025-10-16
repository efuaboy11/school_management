import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:mobile_app/models/school_fee.dart';
import 'package:http/http.dart' as http;

class SchoolFeeNotifier extends StateNotifier<List<SchoolFee>> {
  SchoolFeeNotifier() : super([]);



  Future<String>fetchSchoolFeesPayment(String query) async{
    final token = await AuthService.getAccessToken();
    final String baseUrl = 'http://school.amanilightequity.com/api/payment-school-fees/?search=$query'; 

    try{
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
        }

      );

      if(response.statusCode == 200){
        final List data = json.decode(response.body);
        state = data.map((json) => SchoolFee.fromJson(json)).toList();
        return 'success';
      }else{
        final errorData = jsonDecode(response.body);
        final errorMessages = errorData.values.join(", ");
        print(errorMessages);
        return errorMessages;
      }
    }catch(e, stackTrace){
      print('Unexpected error occurred: $e');
      print('Stack trace: $stackTrace');
      return 'Failed to load student details... Try again';
    }


  }


  Future<String>payFee(Map<String, dynamic> fee) async{
    final token = await AuthService.getAccessToken(); 
      final String baseUrl = 'http://school.amanilightequity.com/api/payment-school-fees/';

    try{
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(fee)
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        final  data = json.decode(response.body);
        state = [...state, data];
        return 'success';

      }else{
        final errorData = jsonDecode(response.body);
        final errorMessages = errorData.values.join(", ");
        print(errorMessages);
        return errorMessages;
      }
    }catch(e, stackTrace){
      print('Unexpected error occurred: $e');
      print('Stack trace: $stackTrace');
      return 'Unexpected error occured';
    }
  }
}

final schoolFeesProvider = StateNotifierProvider<SchoolFeeNotifier, List<SchoolFee>>((ref) {
  return SchoolFeeNotifier();
});