import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shirtify/database/AddCart.dart';

import '../component/Colors.dart';
import '../component/SessionManagement.dart';

class DisplayProduct extends StatefulWidget {
  const DisplayProduct({Key? key, required this.extra}) : super(key: key);
  final Map<String, dynamic> extra;

  @override
  _DisplayProductState createState() => _DisplayProductState();
}

class _DisplayProductState extends State<DisplayProduct> {
  late final String image;
  late final String name;
  late final double price;
  late final String description;
  late final double ratings;
  late String email;
  late String id;
  Map<String, dynamic> userInfo = {};
  int quantity = 1;
  String selectedSize = 'M';

  @override
  void initState() {
    super.initState();
    image = widget.extra['imageUrl'];
    name = widget.extra['name'];
    price = widget.extra['price'];
    description = widget.extra['description'];
    ratings = widget.extra['ratings'];
    LoadUser();
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
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsPallete.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: ColorsPallete.orange,
      ),
      body: Container(
        color: Colors.transparent, // Set the background color here
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: 450, // Adjust the width as needed
                height: 700, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: ColorsPallete.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0), // Add left margin
                      child: Text(
                        "Product Name: $name",
                        style: const TextStyle(
                          fontSize: 20,
                          color: ColorsPallete.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0), // Add left margin
                      child: Text(
                        'Price: ₱$price',
                        style: const TextStyle(
                          fontSize: 20,
                          color: ColorsPallete.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0), // Add left marginma
                      child: Text(
                        "Description: $description",
                        style: const TextStyle(
                          fontSize: 20,
                          color: ColorsPallete.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0), // Add left margin
                      child: Text(
                        'Ratings: $ratings',
                        style: const TextStyle(
                          fontSize: 20,
                          color: ColorsPallete.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0), // Add left and right margin
                      child: Row(
                        children: [
                          const Text(
                            'Quantity:',
                            style: TextStyle(
                              fontSize: 20,
                              color: ColorsPallete.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.remove, color: ColorsPallete.white),
                            onPressed: decrementQuantity,
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 20,
                              color: ColorsPallete.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: ColorsPallete.white),
                            onPressed: incrementQuantity,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0), // Add left and right margin
                      child: Row(
                        children: [
                          const Text(
                            'Size:',
                            style: TextStyle(
                              fontSize: 20,
                              color: ColorsPallete.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            value: selectedSize,
                            dropdownColor: ColorsPallete.orange,
                            items: <String>['S', 'M', 'L', 'XL', 'XXL'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: ColorsPallete.white,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSize = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
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
                              // call the controller
                              print('Add to Cart: $quantity, Size: $selectedSize');

                              Map <String, dynamic> cartData = {
                                'email': email,
                                'userid': id,
                                'productName': name,
                                'price': price,
                                'imageUrl': image,
                                'quantity': quantity,
                                'size': selectedSize,
                              };

                              AddCartService().addCart(cartData, context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsPallete.whitegray, // Background color of the button
                            ),
                            icon: Icon(Icons.add_shopping_cart, color: ColorsPallete.orange), // Add your desired icon here
                            label: Text(
                              'Add to Cart',
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
            ],
          ),
        ),
      ),
    );
  }
}