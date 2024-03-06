import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/endpoints/user.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:furcarev2/utils/common.util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomerActivityLog extends StatefulWidget {
  const CustomerActivityLog({super.key});

  @override
  State<CustomerActivityLog> createState() => _CustomerActivityLogState();
}

class _CustomerActivityLogState extends State<CustomerActivityLog> {
  // State
  String _accessToken = "";

  Future<dynamic> handleGetActivityLogs() async {
    ClientApi clientApi = ClientApi(_accessToken);

    Response<dynamic> response = await clientApi.getMeActivityLog();

    return response.data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final accessTokenProvider = Provider.of<AuthTokenProvider>(
      context,
      listen: false,
    );

    // Retrieve the access token from the provider and assign it to _accessToken
    _accessToken = accessTokenProvider.authToken?.accessToken ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Activity Log",
          style: GoogleFonts.urbanist(
            color: AppColors.primary,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: AppColors.secondary,
      body: FutureBuilder(
        future: handleGetActivityLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.urbanist(
                color: AppColors.primary,
              ),
            ));
          } else if (!snapshot.hasData) {
            return Center(
                child: Text(
              'No data available',
              style: GoogleFonts.urbanist(
                color: AppColors.primary,
              ),
            ));
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 5.0, top: index == 0 ? 5.0 : 0),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    snapshot.data[index]['description'],
                    style: GoogleFonts.urbanist(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    formatDate(
                        DateTime.parse(snapshot.data[index]['createdAt'])),
                    style: GoogleFonts.urbanist(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
