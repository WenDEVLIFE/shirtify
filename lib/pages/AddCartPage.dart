import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shirtify/model/AddCartModel.dart';

import '../component/Colors.dart';
import '../component/SessionManagement.dart';
import '../database/AddToOrder.dart';
import '../database/DeleteAddCart.dart';

class AddCartPage extends StatefulWidget {
  const AddCartPage({Key? key}) : super(key: key);

  @override
  _AddCartPageState createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  final TextEditingController _searchController = TextEditingController();
  List<AddCartModel> products = [];
  List<AddCartModel> filteredProducts = [];
  bool isLoading = true;
  List<bool> checked = [];
  late String email;
  late String id;
  Map<String, dynamic> userInfo = {};
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);
    LoadUser();
  }

  void _filterProducts() {
    setState(() {
      filteredProducts = products
          .where((product) =>
          product.productname.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> LoadUser() async {
    final Sessionmanagement _sessionManager = Sessionmanagement();
    userInfo = (await _sessionManager.getUserInfo())!;
    setState(() {
      email = userInfo['email'];
      id = userInfo['id'];
    });
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('addcart')
        .where('userid', isEqualTo: id)
        .get();

    setState(() {
      products = snapshot.docs.map((doc) {
        return AddCartModel(
          id: doc.id,
          productname: doc['productName'],
          image: doc['imageUrl'],
          size: doc['size'],
          price: doc['price'],
          quantity: doc['quantity'],
        );
      }).toList();
      filteredProducts = products;
      isLoading = false;
      checked = List<bool>.filled(products.length, false);
    });
  }

  void _updateTotalAmount() {
    totalAmount = 0.0;
    for (int i = 0; i < filteredProducts.length; i++) {
      if (checked[i]) {
        totalAmount += filteredProducts[i].price * filteredProducts[i].quantity;
      }
    }
  }

  Future<void> _checkout() async {
    List<AddCartModel> selectedProducts = [];
    for (int i = 0; i < filteredProducts.length; i++) {
      if (checked[i]) {
        selectedProducts.add(filteredProducts[i]);
      }
    }

    if (selectedProducts.isNotEmpty) {
      await _showCreditCardDialog(selectedProducts);
    }
  }

  Future<void> _showCreditCardDialog(List<AddCartModel> selectedProducts) async {
    final TextEditingController cardNumberController = TextEditingController();
    final TextEditingController expiryDateController = TextEditingController();
    final TextEditingController cvvController = TextEditingController();
    final TextEditingController amountController = TextEditingController(
        text: totalAmount.toStringAsFixed(2));

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsPallete.orange,
          title: const Text('Enter Credit Card Information', style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: cardNumberController,
                  decoration: const InputDecoration(labelText: 'Card Number',
                      labelStyle: TextStyle(color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto')),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: expiryDateController,
                  decoration: const InputDecoration(
                      labelText: 'Expiry Date (MM/YY)',
                      labelStyle: TextStyle(color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto')),
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: cvvController,
                  decoration: const InputDecoration(labelText: 'CVV',
                      labelStyle: TextStyle(color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto')),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Amount',
                      labelStyle: TextStyle(color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto')),
                  keyboardType: TextInputType.number,
                  enabled: false,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                if (cardNumberController.text.isEmpty ||
                    expiryDateController.text.isEmpty ||
                    cvvController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: ColorsPallete.orange,
                        title: const Text('Error' , style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto')),
                        content: const Text('Please fill in all fields', style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto')),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK' , style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto')),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Execute the OrderService
                  final OrderService orderService = OrderService();
                  await orderService.addOrder(selectedProducts, id, totalAmount, context);
                  setState(() {
                    products.removeWhere((product) =>
                        selectedProducts.contains(product));
                    filteredProducts = products;
                    checked = List<bool>.filled(products.length, false);
                    totalAmount = 0.0;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add to cart',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: ColorsPallete.orange,
      ),
      body: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 380,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorsPallete.orange),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.w700),
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search a product',
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  color: ColorsPallete.orange,
                ),
              )
                  : filteredProducts.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'You have no items in your cart',
                      style: TextStyle(
                        color: ColorsPallete.orange,
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return InkWell(
                    onTap: () {
                      // Handle the click event here
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: ColorsPallete.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Image.asset(product.image, height: 100, width: 100),
                          const SizedBox(height: 10),
                          Text(
                            product.productname,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\₱${product.price}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Quantity: ${product.quantity}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: checked[index],
                                onChanged: (value) {
                                  setState(() {
                                    checked[index] = value!;
                                    _updateTotalAmount();
                                  });
                                },
                                activeColor: Colors.deepPurpleAccent,
                              ),
                              const Text(
                                'Select item',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.transparent),
                              ),
                              child: ButtonTheme(
                                minWidth: 300,
                                height: 100,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Handle the button press
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: ColorsPallete.orange,
                                        title: const Text('Delete Item', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                        content: const Text('Are you sure you want to delete this item?', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('No', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await DeleteCart.deleteCart(product.id, context);
                                              Navigator.of(context).pop();
                                              setState(() {
                                                products.remove(product);
                                                filteredProducts = products;
                                                checked = List<bool>.filled(products.length, false);
                                                _updateTotalAmount();
                                              });
                                            },
                                            child: const Text('Yes', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                          ),
                                        ],
                                      );
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsPallete.whiteish,
                                  ),
                                  icon: Icon(Icons.delete, color: ColorsPallete.orange),
                                  label: Text(
                                    'Delete to cart',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: ColorsPallete.orange,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.transparent),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text("Total Checkout: ", style: TextStyle(color: ColorsPallete.orange, fontSize: 20, fontWeight: FontWeight.w700)),
                    Text("₱${totalAmount.toStringAsFixed(2)}", style: TextStyle(color: ColorsPallete.orange, fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (totalAmount == 0.0) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: ColorsPallete.orange,
                                title: const Text('Error', style: TextStyle(color: ColorsPallete.white, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                content: const Text('Please select an item to checkout' , style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK' , style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Checkout', style: TextStyle(color: ColorsPallete.orange, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                backgroundColor: ColorsPallete.orange,
                                content: const Text('Are you sure you want to checkout?', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      await _checkout();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Yes', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto')),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsPallete.whiteish,
                      ),
                      icon: Icon(Icons.shopping_cart, color: ColorsPallete.orange),
                      label: Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorsPallete.orange,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}