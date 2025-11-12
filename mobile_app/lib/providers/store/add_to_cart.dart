import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/models/store/add_to_cart.dart';
import 'package:mobile_app/session_active.dart';

class AddToCartNotifier extends StateNotifier<List<AddToCart>> {
  AddToCartNotifier() : super([]);

  Future<String> fetchAddToCart(String query, BuildContext context) async {
    final token = await AuthService.getAccessToken();
    final String baseUrl =
      'https://school.amanilightequity.com/api/cart/?search=$query';

    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if(!mounted) return '';
      bool sessionActive = await SessionActive.handleSession(context, response);
      if(!sessionActive) return '';

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);

        data.sort((a, b) {
          final dateA = DateTime.parse(a['date']);
          final dateB = DateTime.parse(b['date']);
          return dateB.compareTo(dateA); // descending
        });


        state = data.map((json) => AddToCart.fromJson(json)).toList();
        return 'success';
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessages = errorData.values.join(", ");
        print(errorMessages);
        return errorMessages;
      }
    } catch (e, stackTrace) {
      print('Unexpected error occurred: $e');
      print('Stack trace: $stackTrace');
      return 'Failed to load student details... Try again';
    }
  } 

  Future<String> addAddToCart(
      String product,
      String measurement,
      String quantity,
      BuildContext context
    ) async {
    final token = await AuthService.getAccessToken();
    final userId = await AuthService.getUserId();


    Map<String, dynamic> payLoad = {
      'user': userId,
      'product': product,
      'measurement': measurement,
      'quantity': quantity


    };

    try {
      final response = await http.post(
        Uri.parse(
          'https://school.amanilightequity.com/api/cart/'
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(payLoad),
      );

      if (response.statusCode == 200) {
        fetchAddToCart('', context);
        return 'success';
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessages = errorData.values.join(", ");
        print(errorMessages);
        return errorMessages;
      }
    } catch (e, stackTrace) {
      print('Unexpected error occurred: $e');
      print('Stack trace: $stackTrace');
      return 'Failed to update assignment submission... Try again';
    }

  }


  Future<String> deleteAddToCart(int id, BuildContext context) async {
    final token = await AuthService.getAccessToken();

    try {
      final response = await http.delete(
        Uri.parse('https://school.amanilightequity.com/api/cart/$id/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if(!mounted) return '';
      bool sessionActive = await SessionActive.handleSession(context, response);
      if(!sessionActive) return '';

      if (response.statusCode == 204) {
        fetchAddToCart('', context);
        return 'success';
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessages = errorData.values.join(", ");
        print(errorMessages);
        return errorMessages;
      }
    } catch (e, stackTrace) {
      print('Unexpected error occurred: $e');
      print('Stack trace: $stackTrace');
      return 'Failed to delete assignment submission... Try again';
    }
  }


  Future<String> increaseQuanity(
      String productId,  
      BuildContext context
    ) async {
    final token = await AuthService.getAccessToken();

    Map<String, dynamic> payLoad = {
      'product': productId,

    };

    try {
      final response = await http.post(
        Uri.parse(
          'https://school.amanilightequity.com/api/increase-cart-product-quantity/'
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(payLoad),
      );

      if (response.statusCode == 200) {
        fetchAddToCart('', context);
        return 'success';
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessages = errorData.values.join(", ");
        print(errorMessages);
        return errorMessages;
      }
    } catch (e, stackTrace) {
      print('Unexpected error occurred: $e');
      print('Stack trace: $stackTrace');
      return 'Failed to update assignment submission... Try again';
    }
  } 



  Future<String> decreaseQuanity(
      String productId,  
      BuildContext context
    ) async {
    final token = await AuthService.getAccessToken();

    Map<String, dynamic> payLoad = {
      'product': productId,

    };

    try {
      final response = await http.post(
        Uri.parse(
          'https://school.amanilightequity.com/api/decrease-cart-product-quantity/'
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(payLoad),
      );

      if (response.statusCode == 200) {
        fetchAddToCart('', context);
        return 'success';
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessages = errorData.values.join(", ");
        print(errorMessages);
        return errorMessages;
      }
    } catch (e, stackTrace) {
      print('Unexpected error occurred: $e');
      print('Stack trace: $stackTrace');
      return 'Failed to update assignment submission... Try again';
    }
  } 
}

final addToCartProvider =
    StateNotifierProvider<AddToCartNotifier, List<AddToCart>>((ref) {
      return AddToCartNotifier();
    });
 