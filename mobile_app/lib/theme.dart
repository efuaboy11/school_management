import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors>{
  const CustomColors({
    required this.successful,
    required this.pending,
    required this.declined,
    required this.lightBorder,
    required this.lightText,
  });

  final Color successful;
  final Color pending;
  final Color declined;
  final Color lightBorder;
  final Color lightText;

  @override
  CustomColors copyWith({
    Color? successful,
    Color? pending,
    Color? declined,
    Color ? lightBorder,
    Color ? lightText,
  }){
    return CustomColors(
      successful: successful ?? this.successful, 
      pending: pending ?? this.pending, 
      declined: declined ?? this.declined,
      lightBorder: lightBorder ?? this.lightBorder,
      lightText: lightText ?? this.lightText,
    );
      
  }

  @override
  ThemeExtension<CustomColors> lerp(covariant ThemeExtension<CustomColors>? other, double t) {
    if(other is! CustomColors) return this;
    return CustomColors(
      successful:  Color.lerp(successful, other.successful, t)!, 
      pending: Color.lerp(pending, other.pending, t)!, 
      declined: Color.lerp(declined, other.declined, t)!,
      lightBorder: Color.lerp(lightBorder, other.lightBorder, t)!,
      lightText: Color.lerp(lightText, other.lightText, t)!
    );
  }
}