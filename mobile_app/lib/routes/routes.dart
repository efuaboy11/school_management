// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/screens/Auth/forgot_password.dart';
import 'package:mobile_app/screens/Auth/forgot_password_success.dart';
import 'package:mobile_app/screens/Auth/login.dart';
import 'package:mobile_app/screens/home.dart';
import 'package:mobile_app/screens/student/home.dart';
import 'package:mobile_app/screens/student/school_fees/add_school_fees/step1.dart';
import 'package:mobile_app/screens/student/school_fees/add_school_fees/step2.dart';
import 'package:mobile_app/screens/student/school_fees/fee_details.dart';
import 'package:mobile_app/screens/student/school_fees/history.dart';

bool get isLoggedIn => false;

final GoRouter appRouter = GoRouter(
  initialLocation: '/student/home',
  routes:  <GoRoute>[
    GoRoute(
      path: '/',
      name: 'home',
      builder:(context, state) => HomeScreen(),
    ),

    GoRoute(
      path: '/login',
      name: 'login',
      builder:(context, state) => LoginScreen(),
    ),

    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder:(context, state) => ForgotPasswordScreen(),
    ),

    GoRoute(
      path: '/forgot-password-success',
      name: 'forgot-password-success',
      builder:(context, state) => ForgotPasswordSuccessScreen(),
    ),


    GoRoute(
      path: '/student/home',
      name: 'student-gome',
      builder:(context, state) => StudentHomeScreen(),
    ),


    GoRoute(
      path: '/student/fees-history',
      name: 'student-fees-history',
      builder:(context, state){
        return SchoolFeesHistoryScreen();
      },
    ),

    GoRoute(
      path: '/student/fees-history/detail',
      name: 'student-fees-history-detail',
      builder:(context, state) => SchoolFeesDetailScreen(),
    ),


    GoRoute(
      path: '/student/pay-fees',
      name: 'student-fee-payment',
      builder:(context, state) => SchoolFeesPaymentScreen(),
    ),

    GoRoute(
      path: '/student/pay-2',
      name: 'student-fee-payment-2',
      builder:(context, state) => SchoolFeesPaymentScreenTwo(),
    ),

    

    
  ],
  // errorBuilder: (context, state) => ErrorScreen(error: state.error),
);