import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shirtify/component/SessionManagement.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class LoginServices{
  final Sessionmanagement _sessionManager = Sessionmanagement();

  Future <void> loginUser(Map <String, dynamic> userdata, BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Logging in...');

    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: userdata['email']).get();
      if (querySnapshot.docs.isNotEmpty) {
        String id = querySnapshot.docs[0].id;
        String role = querySnapshot.docs[0].get('role');
        String password = querySnapshot.docs[0].get('password');
        if (password == userdata['password']) {

          Map <String, dynamic> extra = {
            'role': role,
            'id': id,
            'email': userdata['email']
          };

          await _sessionManager.saveUserInfo(extra);

          context.go('/bottomnavigation', extra: extra);
          Fluttertoast.showToast(msg: 'Logged in successfully',
            backgroundColor: Colors.green,
            textColor: const Color(0xFFFFFFFF),
            fontSize: 16.0,
          );
        } else {
          print('Incorrect password');
          Fluttertoast.showToast(msg: 'Incorrect password',
            backgroundColor: Colors.red,
            textColor: const Color(0xFFFFFFFF),
            fontSize: 16.0,
          );
        }

      } else {
        print('User does not exist');
      }
    } catch (e) {
      print(e);
    } finally {
      pd.close();
    }
  }
}