import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteCart {
  static Future<void> deleteCart(String id) async {
    try {
      await FirebaseFirestore.instance.collection('cart').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}