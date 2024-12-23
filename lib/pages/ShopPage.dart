import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shirtify/main.dart';

import '../component/Colors.dart';
import '../component/Images.dart';
import '../model/Product.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> products = [
    Product(
        name: 'bench red T-shirt',
        imageUrl: 'assets/images/bench.png',
        price: 500.00,
        description:'Step up your style game with the bold and iconic Bench Red '
            'T-Shirt! Designed for trendsetters who love to stand out, this vibrant'
            ' tee combines unparalleled comfort with timeless urban flair. '
            'Whether you’re hitting the streets or chilling with friends, '
            'the Bench Red T-Shirt is your ultimate go-to for effortless cool.'
            ' Get ready to make a statement—because in this shirt, all eyes are on you!',
        ratings: 4.5),
    Product(
        name: 'Winnie the Pooh T-shirt',
        imageUrl: 'assets/images/pooh.png',
        price: 300.00,
        description: 'This is a T-shirt with Winnie the Pooh print',
        ratings: 4.0),
    // Add more products here
  ];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    setState(() {
      filteredProducts = products
          .where((product) =>
          product.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
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
          'Shop',
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
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return InkWell(
                    onTap: () {
                      // Handle the click event here
                      print('Clicked on ${product.name}');
                      Map <String , dynamic> productData = {
                        'name': product.name,
                        'imageUrl': product.imageUrl,
                        'price': product.price,
                        'description': product.description,
                        'ratings': product.ratings,
                      };

                      context.push('/displayproduct', extra: productData);
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
                          Image.asset(product.imageUrl, height: 100, width: 100), // Adjust the height and width as needed
                          const SizedBox(height: 10), // Space between image and text
                          Text(
                            product.name,
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
                          const SizedBox(height: 10), // Space between price and button
                          Center(
                            child:Container(
                              width: 350, // Adjust the width as needed
                              decoration: BoxDecoration(
                                color: Colors.transparent, // Background color of the TextField
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.transparent), // Border color
                              ),
                              child: ButtonTheme(
                                minWidth: 300, // Adjust the width as needed
                                height: 100, // Adjust the height as needed
                                child:  ElevatedButton.icon(
                                  onPressed: () {
                                    // call the controller
                                    Map <String , dynamic> productData = {
                                      'name': product.name,
                                      'imageUrl': product.imageUrl,
                                      'price': product.price,
                                      'description': product.description,
                                      'ratings': product.ratings,
                                    };

                                    context.push('/displayproduct', extra: productData);

                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsPallete.whiteish, // Background color of the button
                                  ),
                                  icon: Icon(Icons.remove_red_eye_outlined, color: ColorsPallete.orange,), // Add your desired icon here
                                  label: Text('View Product',style: TextStyle(
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
            )
          ],
        ),
      ),
    );
  }
}