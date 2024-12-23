import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shirtify/component/Colors.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterService{

  Future<void> registerUser(Map<String, dynamic> userdata, BuildContext context) async{

    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Registering User' , backgroundColor: ColorsPallete.orange);

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: userdata['email']).get();
      if (querySnapshot.docs.isNotEmpty) {
        pd.close();
        Fluttertoast.showToast(msg: 'User already exists', backgroundColor: Colors.red);
      } else {
        await FirebaseFirestore.instance.collection('users').add(userdata);
        pd.close();
        Fluttertoast.showToast(msg: 'User registered successfully', backgroundColor: Colors.green);
      }

    }catch(e){
      print(e);
    }
    finally{
      pd.close();
    }
  }
}