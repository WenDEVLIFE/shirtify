import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class DeleteCart {
  static Future<void> deleteCart(String id, BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Deleting cart...');

    try {
      await FirebaseFirestore.instance.collection('addcart').doc(id).delete();
      Fluttertoast.showToast(msg: 'Cart deleted successfully', backgroundColor: CupertinoColors.systemGreen);
    } catch (e) {
      print(e);
    } finally {
      pd.close();
    }
  }
}