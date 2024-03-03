import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  final String redirectPath;

  const SuccessScreen(BuildContext context,
      {Key? key, required this.redirectPath})
      : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/success.gif',
          scale: 2,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.of(context).pushReplacementNamed(widget.redirectPath);
    });
  }
}
