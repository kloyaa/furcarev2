import 'package:flutter/material.dart';
import 'package:furcarev2/classes/registration.dart';

class RegistrationProvider extends ChangeNotifier {
  BasicInfo? _basicInfo;
  Address? _address;
  Contact? _contact;

  BasicInfo? get basicInfo => _basicInfo;
  Address? get address => _address;
  Contact? get contact => _contact;

  void setBasicInfo(BasicInfo value) {
    _basicInfo = value;
    notifyListeners();
  }

  void setAddress(Address value) {
    _address = value;
    notifyListeners();
  }

  void setContact(Contact value) {
    _contact = value;
    notifyListeners();
  }
}
