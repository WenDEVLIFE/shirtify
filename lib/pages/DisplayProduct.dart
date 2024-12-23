import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/Colors.dart';

class DisplayProduct extends StatefulWidget {
  const DisplayProduct({Key? key, required this.extra}) : super(key: key);
  final Map<String, dynamic> extra;


  @override
  _DisplayProductState createState() => _DisplayProductState();
}

class _DisplayProductState extends State<DisplayProduct>{
  late final String image;
  late final String name;
  late final double price;
  late final String description;
  late final double ratings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = widget.extra['imageUrl'];
    name = widget.extra['name'];
    price = widget.extra['price'];
    description = widget.extra['description'];
    ratings = widget.extra['ratings'];

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
                  height: 630,
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
                          padding: const EdgeInsets.only(left: 10.0), // Add left margin
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

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsPallete.whitegray, // Background color of the button
                                ),
                                icon: Icon(Icons.add_shopping_cart, color: ColorsPallete.orange,), // Add your desired icon here
                                label: Text('Add to Cart',style: TextStyle(
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
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}

