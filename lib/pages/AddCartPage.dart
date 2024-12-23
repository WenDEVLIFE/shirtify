import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shirtify/model/AddCartModel.dart';

import '../component/Colors.dart';
import '../component/SessionManagement.dart';

class AddCartPage extends StatefulWidget {
  const AddCartPage({Key? key}) : super(key: key);

  @override
  _AddCartPageState createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  final TextEditingController _searchController = TextEditingController();
  List<AddCartModel> products = [];
  List<AddCartModel> filteredProducts = [];
  bool isLoading = true; // Add a flag to indicate loading state
  List<bool> checked = [];
  late String email;
  late String id;
  Map<String, dynamic> userInfo = {};

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
    print('Email: $email');
    print('ID: $id');
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    // Retrieve products from Firebase
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('addcart')
        .where('userid', isEqualTo: id)
        .get();

    setState(() {
      products = snapshot.docs.map((doc) {
        return AddCartModel(
          id: doc['userid'],
          productname: doc['productName'],
          image: doc['imageUrl'],
          size: doc['size'],
          price: doc['price'],
          quantity: doc['quantity'],
        );
      }).toList();
      filteredProducts = products;
      isLoading = false; // Set loading to false after loading products
      checked = List<bool>.filled(products.length, false);
    });
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
        color: Colors.transparent, // Set the background color here
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 380, // Adjust the width as needed
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the TextField
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorsPallete.orange), // Border color
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
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Optional margin
                      decoration: BoxDecoration(
                        color: ColorsPallete.orange, // Set the background color here
                        borderRadius: BorderRadius.circular(10), // Set the border radius here
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Image.asset(product.image, height: 100, width: 100), // Adjust the height and width as needed
                          const SizedBox(height: 10), // Space between image and text
                          Text(
                            product.productname,
                            style: const TextStyle(
                              color: Colors.white, // Set the text color here
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10), // Space between text and price
                          Text(
                            '\₱${product.price}',
                            style: const TextStyle(
                              color: Colors.white, // Set the text color here
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10), // Space between price and quantity
                          Text(
                            'Quantity: ${product.quantity}',
                            style: const TextStyle(
                              color: Colors.white, // Set the text color here
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10), // Space between quantity and checkbox
                          Checkbox(
                            value: checked[index],
                            onChanged: (bool? value) {
                              setState(() {
                                checked[index] = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 10), // Space between checkbox and button
                          Center(
                            child: Container(
                              width: 350, // Adjust the width as needed
                              decoration: BoxDecoration(
                                color: Colors.transparent, // Background color of the TextField
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.transparent), // Border color
                              ),
                              child: ButtonTheme(
                                minWidth: 300, // Adjust the width as needed
                                height: 100, // Adjust the height as needed
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Handle the button press
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsPallete.whiteish, // Background color of the button
                                  ),
                                  icon: Icon(Icons.remove_red_eye_outlined, color: ColorsPallete.orange), // Add your desired icon here
                                  label: Text(
                                    'View Product',
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: 350, // Adjust the width as needed
              decoration: BoxDecoration(
                color: Colors.transparent, // Background color of the TextField
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.transparent), // Border color
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Set scroll direction to horizontal
                child: Row(
                  children: [
                    // Add your child widgets here
                    Text("Total Checkout: ", style: TextStyle(color: ColorsPallete.orange, fontSize: 20, fontWeight: FontWeight.w700)),
                    Text("₱0.00", style: TextStyle(color: ColorsPallete.orange, fontSize: 20, fontWeight: FontWeight.w700)),
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