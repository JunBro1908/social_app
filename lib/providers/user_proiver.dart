import 'package:flutter/material.dart';
import 'package:social_app/resources/auth_methods.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  // global variable
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  // getter method
  User? get getUser => _user;

  Future<void> refresUser() async {
    User user = await _authMethods.getUserDetail();
    _user = user;
    notifyListeners();
  }
}
