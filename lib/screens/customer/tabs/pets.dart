import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';

class CustomerTabPets extends StatefulWidget {
  const CustomerTabPets({super.key});

  @override
  State<CustomerTabPets> createState() => _CustomerTabPetsState();
}

class _CustomerTabPetsState extends State<CustomerTabPets> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Text('Pets'),
      ),
    );
  }
}
