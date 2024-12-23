import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class UpdatePassword {
  Future<void> updatePassword(Map<String, dynamic> userdata, BuildContext context, void Function() clearFields) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Updating Password');
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(userdata['id']).get();

      if (documentSnapshot.exists) {
        String oldpassword = documentSnapshot.get('password');
        if (oldpassword == userdata['oldpassword']) {
          await FirebaseFirestore.instance.collection('users').doc(userdata['id']).update({'password': userdata['newpassword']});
          Fluttertoast.showToast(msg: 'Password Updated Successfully', backgroundColor: Colors.green);
          clearFields();
        } else {
          Fluttertoast.showToast(msg: 'Old Password is incorrect', backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      print(e);
    } finally {
      pd.close();
    }
  }
}