import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/classes/booking.dart';
import 'package:furcarev2/classes/login_response.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/endpoints/booking.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:furcarev2/providers/client.dart';
import 'package:furcarev2/screens/customer/payment/preview.dart';
import 'package:furcarev2/utils/common.util.dart';
import 'package:furcarev2/widgets/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookTransit extends StatefulWidget {
  const BookTransit({super.key});

  @override
  State<BookTransit> createState() => _BookTransitState();
}

class _BookTransitState extends State<BookTransit> {
  // State
  String _accessToken = "";
  DateTime? _selectedDateTime;
  String _selectedPet = "";
  String _selectedPetId = "";
  List _pets = [];

  Future<void> handleSubmit() async {
    BookingApi booking = BookingApi(_accessToken);

    if (_selectedDateTime == null) {
      return showSnackBar(
        context,
        "Please select a schedule",
        color: AppColors.danger,
        fontSize: 10.0,
      );
    }

    if (_selectedPetId.isEmpty) {
      return showSnackBar(
        context,
        "Please select a pet",
        color: AppColors.danger,
        fontSize: 10.0,
      );
    }

    try {
      Response<dynamic> response = await booking.transitBooking(
        TransitgPayload(
          pet: _selectedPetId,
          schedule: "$_selectedDateTime",
        ),
      );

      if (context.mounted) {
        showSnackBar(
          context,
          "Booked successfully!",
          color: Colors.green,
          fontSize: 10.0,
          duration: 1,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPreview(
              serviceName: "transit",
              date: response.data['date'],
              referenceNo: response.data['referenceNo'],
            ),
          ),
        );
      }
    } on DioException catch (e) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(e.response?.data);
      if (context.mounted) {
        showSnackBar(
          context,
          errorResponse.message,
          color: AppColors.danger,
          fontSize: 10.0,
        );
      }
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2024, 12, 31),
    );

    if (pickedDate != null) {
      if (context.mounted) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          setState(() {
            _selectedDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          });
        }
      }
    }
  }

  List<DropdownMenuItem<dynamic>> getPets() {
    List<DropdownMenuItem<dynamic>> items = [];
    for (var i = 0; i < _pets.length; i++) {
      DropdownMenuItem item = DropdownMenuItem(
        value: _pets[i]['_id'], // Assuming _id is the unique identifier
        child: Text(
          _pets[i]['name'],
          style: GoogleFonts.urbanist(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

      items.add(item);
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    final accessTokenProvider = Provider.of<AuthTokenProvider>(
      context,
      listen: false,
    );
    final clientProvider = Provider.of<ClientProvider>(
      context,
      listen: false,
    );

    _accessToken = accessTokenProvider.authToken?.accessToken ?? '';
    _pets = clientProvider.pets ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Pick up and Drop off",
          style: GoogleFonts.urbanist(
            color: AppColors.primary,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Pet',
              style: GoogleFonts.urbanist(
                color: AppColors.primary.withOpacity(0.5),
                fontWeight: FontWeight.w400,
                fontSize: 8.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(5.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: DropdownButton<dynamic>(
                  value: _selectedPet.isNotEmpty ? _selectedPet : null,
                  underline: const SizedBox(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      _selectedPet = newValue!;
                      _selectedPetId = newValue;
                    });
                  },
                  items: getPets(),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Select Schedule',
              style: GoogleFonts.urbanist(
                color: AppColors.primary.withOpacity(0.5),
                fontWeight: FontWeight.w400,
                fontSize: 8.0,
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () => _selectDateTime(context),
              child: Container(
                padding: const EdgeInsets.all(25.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    _selectedDateTime != null
                        ? formatDate(_selectedDateTime!)
                        : 'Select Schedule',
                    style: GoogleFonts.urbanist(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                handleSubmit();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    'Submit',
                    style: GoogleFonts.urbanist(
                      color: AppColors.secondary,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
