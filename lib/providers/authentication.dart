import 'package:flutter/material.dart';
import 'package:furcarev2/classes/authtoken.dart';

class AuthTokenProvider extends ChangeNotifier {
  AuthToken? _authToken;

  AuthToken? get authToken => _authToken;

  void setAuthToken(String accessToken) {
    _authToken = AuthToken(accessToken);
    notifyListeners();
  }
}
