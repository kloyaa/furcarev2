import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/classes/booking.dart';
import 'package:furcarev2/classes/login_response.dart';
import 'package:furcarev2/classes/pet.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/endpoints/booking.dart';
import 'package:furcarev2/endpoints/user.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:furcarev2/providers/client.dart';
import 'package:furcarev2/screens/customer/payment/preview.dart';
import 'package:furcarev2/utils/common.util.dart';
import 'package:furcarev2/widgets/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookBoarding extends StatefulWidget {
  const BookBoarding({super.key});

  @override
  State<BookBoarding> createState() => _BookBoardingState();
}

class _BookBoardingState extends State<BookBoarding> {
  // State
  late TimeOfDay _selectedTime;
  late int _selectedDay;
  String _accessToken = "";
  String _selectedCageId = "";
  String _selectedDate = "";
  String _selectedPet = "";
  String _selectedPetId = "";
  List _pets = [];

  Future<List<dynamic>> handleGetCages() async {
    ClientApi clientApi = ClientApi(_accessToken);

    Response<dynamic> response = await clientApi.getCages();

    return response.data;
  }

  Future<List<dynamic>> handleGetPets() async {
    ClientApi clientApi = ClientApi(_accessToken);
    try {
      Response<dynamic> response = await clientApi.getMePets();
      return response.data;
    } on DioException catch (e) {
      return [];
    }
  }

  Future<void> handleSubmitBooking() async {
    BookingApi booking = BookingApi(_accessToken);

    if (_selectedCageId.isEmpty) {
      return showSnackBar(
        context,
        "Please select a cage",
        color: AppColors.danger,
        fontSize: 10.0,
      );
    }

    if (_selectedDate.isEmpty) {
      return showSnackBar(
        context,
        "Please select a schedule",
        color: AppColors.danger,
        fontSize: 10.0,
      );
    }

    if (_selectedPet.isEmpty) {
      return showSnackBar(
        context,
        "Please select a pet",
        color: AppColors.danger,
        fontSize: 10.0,
      );
    }

    final formattedDate = DateTime.parse(_selectedDate);
    DateTime schedule = DateTime(
      formattedDate.year,
      formattedDate.month,
      formattedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    try {
      Response<dynamic> response = await booking.boardBooking(
        BoardingPayload(
          cage: _selectedCageId,
          pet: _selectedPetId,
          schedule: schedule.toUtc().toIso8601String(),
          daysOfStay: _selectedDay,
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
              serviceName: "boarding",
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
    // TODO: implement initState
    super.initState();

    final accessTokenProvider = Provider.of<AuthTokenProvider>(
      context,
      listen: false,
    );

    final clientProvider = Provider.of<ClientProvider>(
      context,
      listen: false,
    );

    // Retrieve the access token from the provider and assign it to _accessToken
    _accessToken = accessTokenProvider.authToken?.accessToken ?? '';
    _selectedTime = const TimeOfDay(hour: 7, minute: 0);
    _selectedDay = 1;
    _pets = clientProvider.pets ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Boarding",
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
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.single,
                  ),
                  value: const [],
                  onValueChanged: (dates) {
                    final String date = dates[0]!.toIso8601String();
                    _selectedDate = date.substring(0, 10);
                  },
                )),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: DropdownButton<TimeOfDay>(
                        value: _selectedTime,
                        underline: const SizedBox(),
                        onChanged: (TimeOfDay? newValue) {
                          setState(() {
                            _selectedTime = newValue!;
                          });
                        },
                        items: List<DropdownMenuItem<TimeOfDay>>.generate(
                          15, // Total number of items (9 PM - 7 AM = 14 hours)
                          (int index) {
                            final hour = index + 7; // Start from 7 AM
                            return DropdownMenuItem<TimeOfDay>(
                              value: TimeOfDay(hour: hour % 24, minute: 0),
                              child: Text(
                                _formatTime(hour),
                                style: GoogleFonts.urbanist(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: DropdownButton<int>(
                        value: _selectedDay,
                        underline: const SizedBox(),
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedDay = newValue!;
                          });
                        },
                        items: List<DropdownMenuItem<int>>.generate(
                          31, // Total number of days (1 to 31)
                          (int index) {
                            final day = index + 1; // Start from 1
                            return DropdownMenuItem<int>(
                              value: day,
                              child: Text(
                                "$day day(s)",
                                style: GoogleFonts.urbanist(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Container(
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
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              'Cage Size',
              style: GoogleFonts.urbanist(
                color: AppColors.primary.withOpacity(0.5),
                fontWeight: FontWeight.w400,
                fontSize: 8.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: FutureBuilder(
                future: handleGetCages(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Opacity(
                        opacity: snapshot.data?[index]['available'] ? 1 : 0.3,
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                _selectedCageId == snapshot.data?[index]['_id']
                                    ? Colors.purple
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: const EdgeInsets.only(bottom: 5.0),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                _selectedCageId = snapshot.data?[index]['_id'];
                              });
                            },
                            title: Text(
                              snapshot.data?[index]['title'],
                              style: GoogleFonts.urbanist(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: _selectedCageId ==
                                        snapshot.data?[index]['_id']
                                    ? Colors.white
                                    : AppColors.primary,
                              ),
                            ),
                            trailing: Text(
                              "${snapshot.data?[index]['used']}/${snapshot.data?[index]['limit']}",
                              style: GoogleFonts.urbanist(
                                fontSize: 12.0,
                                color: _selectedCageId ==
                                        snapshot.data?[index]['_id']
                                    ? Colors.white
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                execOnConfirm(
                  message: "Proceed with board booking",
                  method: () => handleSubmitBooking(),
                  context,
                );
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

  String _formatTime(int hour) {
    final isPM = hour >= 12;
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    final displaySuffix = isPM ? ' PM' : ' AM';
    return '$displayHour:00$displaySuffix';
  }
}
