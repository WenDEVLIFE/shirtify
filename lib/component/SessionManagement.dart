import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sessionmanagement {
  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', userInfo['email']);
    prefs.setString('role', userInfo['role']);
    prefs.setString('id', userInfo['id']);
    print('User info saved');

  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('email')) {
      return {
        'email': prefs.getString('email'),
        'role': prefs.getString('role'),
        'id': prefs.getString('id'),
      };

    }
    return null;
  }

  Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('role');
    prefs.remove('id');
    Fluttertoast.showToast(msg: 'Logged out successfully',
      backgroundColor: const Color(0xFF6E738E),
      textColor: const Color(0xFFFFFFFF),
      fontSize: 16.0,
    );
  }
}