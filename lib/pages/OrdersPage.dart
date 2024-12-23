import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shirtify/model/OrderModel.dart';
import 'package:shirtify/database/LoadOrder.dart';
import 'package:shirtify/database/DeleteOrderHistory.dart';

import '../component/Colors.dart';
import '../component/SessionManagement.dart';

class Orderspage extends StatefulWidget {
  const Orderspage({Key? key}) : super(key: key);

  @override
  OrderState createState() => OrderState();
}

class OrderState extends State<Orderspage> {
  final TextEditingController _searchController = TextEditingController();
  List<Ordermodel> products = [];
  List<Ordermodel> filteredProducts = [];
  bool isLoading = true;
  late StreamSubscription<List<Ordermodel>> _subscription;
  double totalAmount = 0.0;
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
    _loadProducts();
  }

  void _loadProducts() {
    final LoadOrder loadOrder = LoadOrder();
    _subscription = loadOrder.loadProducts(id).listen((loadedProducts) {
      setState(() {
        products = loadedProducts;
        filteredProducts = products;
        isLoading = false;
        _updateTotalAmount();
      });
    });
  }

  void _updateTotalAmount() {
    totalAmount = 0.0;
    for (var product in filteredProducts) {
      totalAmount += product.total;
    }
  }

  Future<void> _deleteOrder(String orderId) async {
    final DeleteOrderHistory deleteOrderHistory = DeleteOrderHistory();
    await deleteOrderHistory.deleteOrderHistory(orderId, context);
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
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
                      'You have no items in your orders',
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
                          Text(
                            ' Quantity: ${product.quantity}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            ' Size: ${product.size}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            ' Total: ${product.total}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            ' Paid Service: ${product.paidService}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            ' Order Date: ${product.orderDate} at ${product.orderTime}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
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
                                    _deleteOrder(product.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsPallete.whiteish,
                                  ),
                                  icon: Icon(Icons.delete, color: ColorsPallete.orange),
                                  label: Text(
                                    'Delete Order History',
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
                    Text("Total Orders: ", style: TextStyle(color: ColorsPallete.orange, fontSize: 20, fontWeight: FontWeight.w700)),
                    Text("₱${totalAmount.toStringAsFixed(2)}", style: TextStyle(color: ColorsPallete.orange, fontSize: 20, fontWeight: FontWeight.w700)),
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