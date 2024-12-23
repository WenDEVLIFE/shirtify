import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class DeleteOrderHistory {
  Future<void> deleteOrderHistory(String orderId, BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Deleting Order');
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).delete();
      Fluttertoast.showToast(msg: 'Order Deleted', backgroundColor: CupertinoColors.systemGreen);
    } catch (e) {
      print(e);
    } finally {
      pd.close();
    }
  }
}