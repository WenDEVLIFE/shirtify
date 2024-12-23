import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shirtify/model/AddCartModel.dart';

class LoadAddCart {
  Stream<List<AddCartModel>> loadProducts(String userId) {
    // Retrieve products from Firebase with a snapshot listener
    return FirebaseFirestore.instance
        .collection('addcart')
        .where('userid', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AddCartModel(
          id: doc.id,
          productname: doc['productName'],
          image: doc['imageUrl'],
          size: doc['size'],
          price: doc['price'],
          quantity: doc['quantity'],
        );
      }).toList();
    });
  }
}