import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shirtify/model/OrderModel.dart';

class LoadOrder {
  Stream<List<Ordermodel>> loadProducts(String userId) {
    // Retrieve products from Firebase with a snapshot listener
    return FirebaseFirestore.instance
        .collection('orders')
        .where('userid', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Ordermodel(
          id: doc.id,
          productname: doc['productName'],
          image: doc['imageUrl'],
          size: doc['size'],
          price: doc['price'],
          quantity: doc['quantity'],
          total: doc['totalAmount'],
          paidService: doc['paidService'],
          orderDate: doc['orderDate'],
          orderTime: doc['orderTime'],
        );
      }).toList();
    });
  }
}