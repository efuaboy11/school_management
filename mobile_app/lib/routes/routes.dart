// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/screens/Auth/forgot_password.dart';
import 'package:mobile_app/screens/Auth/forgot_password_success.dart';
import 'package:mobile_app/screens/Auth/login.dart';
import 'package:mobile_app/screens/home.dart';
import 'package:mobile_app/screens/student/assignment/assigment.dart';
import 'package:mobile_app/screens/student/assignment/assignment_details.dart';
import 'package:mobile_app/screens/student/assignment_submission/assigment_submission.dart';
import 'package:mobile_app/screens/student/assignment_submission/assignment_submission_details.dart';
import 'package:mobile_app/screens/student/assignment_submission/submit_assignment.dart';
import 'package:mobile_app/screens/student/bills/add_bills/step1.dart';
import 'package:mobile_app/screens/student/bills/bill_details.dart';
import 'package:mobile_app/screens/student/bills/history.dart';
import 'package:mobile_app/screens/student/class_notifications/class_notification.dart';
import 'package:mobile_app/screens/student/class_timetable/class_timetable.dart';
import 'package:mobile_app/screens/student/general_notification/general_notification.dart';
import 'package:mobile_app/screens/student/home.dart';
import 'package:mobile_app/screens/student/scheme_of_work/scheme_of_work.dart';
import 'package:mobile_app/screens/student/scheme_of_work/select_term_scheme.dart';
import 'package:mobile_app/screens/student/school_fees/add_school_fees/step1.dart';
import 'package:mobile_app/screens/student/school_fees/fee_details.dart';
import 'package:mobile_app/screens/student/school_fees/history.dart';

bool get isLoggedIn => false;

final GoRouter appRouter = GoRouter(
  initialLocation: '/student/home',
  routes:  <GoRoute>[
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: HomeScreen()
      ),
    ),

    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: LoginScreen()
      ),
    ),

    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: ForgotPasswordScreen()
      ),
    ),

    GoRoute(
      path: '/forgot-password-success',
      name: 'forgot-password-success',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: ForgotPasswordSuccessScreen()
      ),
    ),


    GoRoute(
      path: '/student/home',
      name: 'student-gome',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: StudentHomeScreen()
      ),
    ),


    GoRoute(
      path: '/student/fees-history',
      name: 'student-fees-history',
      pageBuilder: (context, state){
        return MaterialPage(
          key: state.pageKey,
          child: SchoolFeesHistoryScreen()
        );
      },
    ),

    GoRoute(
      path: '/student/fees-history/detail',
      name: 'student-fees-history-detail',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: SchoolFeesDetailScreen()
      ),
    ),


    GoRoute(
      path: '/student/pay-fees',
      name: 'student-fee-payment',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: SchoolFeesPaymentScreen()
      ),
    ),



    GoRoute(
      path: '/student/bills-history',
      name: 'student-bills-history',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: BillsHistoryScreen()
      ),
    ),

    GoRoute(
      path: '/student/bills-history/details',
      name: 'student-bills-history-details',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: BillsDetailScreen()
      ),
    ),

    GoRoute(
      path: '/student/bills-payment',
      name: 'student-bills-payment',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: BillPaymentScreen()
      ),
    ),

    GoRoute(
      path: '/student/assignment',
      name: 'student-assignment',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: AssignmentScreen()
      ),
    ),

    GoRoute(
      path: '/student/assignment-details',
      name: 'student-assignment-details',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: AssignmentDetailsScreen()
      ),
    ),


    GoRoute(
      path: '/student/assignment-submission',
      name: 'student-assignment-submission',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: AssignmentSubmissionScreen()
      ),
    ),

    GoRoute(
      path: '/student/assignment-submission-details',
      name: 'student-assignment-submission-details',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: AssignmentSubmisionDetailsScreen()
      ),
    ),


    GoRoute(
      path: '/student/submit-assignment',
      name: 'student-submit-assignment',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: SubmitAssignmentScreen()
      ),
    ),

    GoRoute(
      path: '/student/class-timetable',
      name: 'student-class-timetable',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: ClassTimeTableScreen()
      ),
    ),

    GoRoute(
      path: '/student/scheme/select-term',
      name: 'student-scheme-selct-term',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: SelectTermSchemeScreen()
      ),
    ),

    GoRoute(
      path: '/student/scheme',
      name: 'student-scheme',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: SchemeOfWorkScreen()
      ),
    ),

    GoRoute(
      path: '/student/notification',
      name: 'student-notification',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: GeneralNotificationScreen()
      ),
    ),


    GoRoute(
      path: '/student/class-notification',
      name: 'student-class-notification',
      pageBuilder:(context, state) => MaterialPage(
        key: state.pageKey,
        child: ClassNotificationScreen()
      ),
    ),

    

    
  ],
  // errorBuilder: (context, state) => ErrorScreen(error: state.error),
);