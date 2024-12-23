import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shirtify/model/AddCartModel.dart';

class OrderService {
  Future<void> addOrder(List<AddCartModel> selectedProducts, String userId) async {
    final CollectionReference orders = FirebaseFirestore.instance.collection('orders');
    final CollectionReference cart = FirebaseFirestore.instance.collection('addcart');

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (var product in selectedProducts) {
      DocumentReference orderRef = orders.doc();
      batch.set(orderRef, {
        'userid': userId,
        'productName': product.productname,
        'imageUrl': product.image,
        'size': product.size,
        'price': product.price,
        'quantity': product.quantity,
        'orderDate': FieldValue.serverTimestamp(),
      });

      DocumentReference cartRef = cart.doc(product.id);
      batch.delete(cartRef);
    }

    await batch.commit();
  }
}