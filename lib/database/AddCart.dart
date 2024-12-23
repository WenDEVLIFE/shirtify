import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class AddCartService {

  Future <void> addCart(Map <String, dynamic> cartData, BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Adding to cart...');
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('addcart').where('userid', isEqualTo: cartData['userid']).get();
      if (querySnapshot.docs.isNotEmpty) {

      Fluttertoast.showToast(msg: 'Item already in cart',
        backgroundColor: Colors.red,
        textColor: const Color(0xFFFFFFFF),
        fontSize: 16.0,
      );
      } else {
        await FirebaseFirestore.instance.collection('addcart').add(cartData);
        Fluttertoast.showToast(msg: 'Item added to cart',
          backgroundColor: Colors.green,
          textColor: const Color(0xFFFFFFFF),
          fontSize: 16.0,
        );
      }

    } catch (e) {
      print(e);
    } finally {
      pd.close();
    }


  }
}