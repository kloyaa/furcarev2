import 'package:flutter/material.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:furcarev2/providers/registration.dart';
import 'package:furcarev2/screens/admin/reports/screen_checkins.dart';
import 'package:furcarev2/screens/admin/reports/screen_service_usage.dart';
import 'package:furcarev2/screens/admin/reports/screen_transactions.dart';
import 'package:furcarev2/screens/admin/screen_customer_management.dart';
import 'package:furcarev2/screens/admin/screen_profile.dart';
import 'package:furcarev2/screens/admin/screen_staff_enrollment.dart';
import 'package:furcarev2/screens/admin/screen_staff_management.dart';
import 'package:furcarev2/screens/auth/login/screen_admin_login.dart';
import 'package:furcarev2/screens/auth/register/screen_customer_registration.dart';
import 'package:furcarev2/screens/customer/screen_create_owner.dart';
import 'package:furcarev2/screens/customer/screen_create_pet.dart';
import 'package:furcarev2/screens/customer/screen_create_profile_2.dart';
import 'package:furcarev2/screens/customer/screen_dashboard.dart';
import 'package:furcarev2/screens/customer/screen_create_profile_1.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/success.gif'), context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthTokenProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
      ],
      child: MaterialApp(
        title: 'Furcare v2',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const ScreenAdminLogin(), // for admin
          // '/': (context) => const ScreenCustomerLogin(), // for customer
          '/c/register': (context) => const ScreenCustomerRegister(),
          '/c/main': (context) => const CustomerMain(), // for admin
          '/c/create/profile/1': (context) => const CreateProfileStep1(),
          '/c/create/profile/2': (context) => const CreateProfileStep2(),
          '/c/create/profile/owner': (context) => const CreateOwner(),
          '/c/create/profile/pet': (context) => const CreatePet(),

          // When navigating to the "/second" route, build the SecondScreen widget.
          '/a/management/staff': (context) => const AdminStaffManagement(),
          '/a/management/staff/enrollment': (context) =>
              const AdminStaffEnrollment(),
          '/a/management/customers': (context) =>
              const AdminCustomerManagement(),
          '/a/report/checkins': (context) => const Checkins(),
          '/a/report/service-usage': (context) => const ServiceUsage(),
          '/a/report/transactions': (context) => const Transactions(),

          '/a/profile': (context) => const AdminProfile(),
        },
      ),
    );
  }
}
