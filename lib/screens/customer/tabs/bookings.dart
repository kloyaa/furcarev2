import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';

class CustomerTabBookings extends StatefulWidget {
  const CustomerTabBookings({super.key});

  @override
  State<CustomerTabBookings> createState() => _CustomerTabBookingsState();
}

class _CustomerTabBookingsState extends State<CustomerTabBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Text('Bookings'),
      ),
    );
  }
}
