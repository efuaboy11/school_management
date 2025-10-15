import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/auth_service.dart';
import 'package:mobile_app/models/student_details.dart';


class StudentDetailsNotifer extends StateNotifier<StudentDetails>{
    StudentDetailsNotifer() : super(StudentDetails.empty());

    Future<String> fetchStudentDetails() async{
      final userId = await AuthService.getUserId();
      final token = await AuthService.getAccessToken(); 
      print(userId);


      try{
        final response = await http.get(
          Uri.parse('http://school.amanilightequity.com/api/students/$userId/'),
          headers: {
            'Authorization': 'Bearer $token'
          }
        );

        if(response.statusCode == 200){
          final data = json.decode(response.body);
          state = StudentDetails.fromJson(data);
          return 'success';
          
        }else{
          final errorData = jsonDecode(response.body);
          final errorMessages = errorData.values.join(", ");
          print(errorMessages);
          return 'Failed to load user';
        }
      }catch(e, stackTrace){
        print('Unexpected error occurred: $e');
        print('Stack trace: $stackTrace');
        return 'Failed to load student details... Try again';
      }


    }

    Future<String>updateStudentDetails(Map<String, dynamic> details) async{
      final userId = await AuthService.getUserId();
      final token = await AuthService.getAccessToken(); 

      try{
        final response = await http.patch(
          Uri.parse('http://school.amanilightequity.com/api/students/$userId/'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode(details)
        );
        if(response.statusCode == 200 || response.statusCode == 201){
          final data = json.decode(response.body);
          state = StudentDetails.fromJson(data);
          print('success');
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

final studentDetailsProvider = StateNotifierProvider<StudentDetailsNotifer, StudentDetails>((ref) {
  return StudentDetailsNotifer();
});