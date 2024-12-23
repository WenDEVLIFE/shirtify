import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shirtify/model/AddCartModel.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class OrderService {
  Future<void> addOrder(List<AddCartModel> selectedProducts, String userId, double totalAmount, BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Placing order...');

   try{
     final CollectionReference orders = FirebaseFirestore.instance.collection('orders');
     final CollectionReference cart = FirebaseFirestore.instance.collection('addcart');

     WriteBatch batch = FirebaseFirestore.instance.batch();

     for (var product in selectedProducts) {
       DocumentReference orderRef = orders.doc();
       int totalprice = product.price.toInt() * product.quantity;
       DateTime now = DateTime.now();
       String formattedDate = "${now.year}-${now.month}-${now.day}";
       String time = "${now.hour}:${now.minute}";

       batch.set(orderRef, {
         'userid': userId,
         'productName': product.productname,
         'imageUrl': product.image,
         'size': product.size,
         'price': product.price,
         'quantity': product.quantity,
         'orderDate': formattedDate,
         'orderTime': time,
         'totalAmount': totalprice,
         'paidService': 'Credit Card',
       });

       DocumentReference cartRef = cart.doc(product.id);
       batch.delete(cartRef);
     }
     Fluttertoast.showToast(msg: 'Order placed successfully', backgroundColor: Colors.green);

     await batch.commit();
   } catch (e) {
     Fluttertoast.showToast(msg: 'Failed to place order', backgroundColor: Colors.red);
     print(e);
   } finally {
     pd.close();
   }
  }
}