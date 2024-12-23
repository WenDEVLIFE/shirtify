import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../component/Colors.dart';

class Faqpage extends StatefulWidget {
  const Faqpage({Key? key}) : super(key: key);

  @override
  FaqState createState() => FaqState();
}

class FaqState extends State<Faqpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsPallete.white,
            size: 50,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'FAQ',
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Add padding around the scroll view
            child: SingleChildScrollView(
              child: Container(
                width: 380, // Set the desired width here
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: ColorsPallete.orange,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsPallete.whiteish,
                        border: Border.all(color: ColorsPallete.orange, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/icons/transparent.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '1. What is Shirtify?\n'
                          'Shirtify is an online platform that specializes in premium-quality T-shirts with unique, customizable designs. Whether you’re shopping for pre-made styles or want to create your own, we make it easy to wear your personality.\n\n'
                          '2. How do I customize my T-shirt?\n'
                          'Customizing your T-shirt is simple! Use our intuitive design tool to upload images, add text, choose fonts, and select colors. Once your design is ready, just add it to your cart and place your order!\n\n'
                          '3. What materials are your T-shirts made from?\n'
                          'Our T-shirts are made from high-quality materials, such as 100% cotton, cotton-polyester blends, or organic fabrics, ensuring comfort, durability, and eco-friendliness.\n\n'
                          '4. What sizes do you offer?\n'
                          'We offer a wide range of sizes, from XS to 5XL, to ensure the perfect fit for everyone. Please refer to our size chart for detailed measurements.\n\n'
                          '5. How long does shipping take?\n'
                          'Shipping times vary depending on your location and order customization. Standard delivery takes 5–7 business days, while express options are available for faster delivery.\n\n'
                          '6. Do you ship internationally?\n'
                          'Yes! Shirtify ships to most countries worldwide. Shipping fees and delivery times may vary based on your location.\n\n'
                          '7. Can I return or exchange a T-shirt?\n'
                          'Absolutely! If your T-shirt arrives damaged or with a defect, contact us within 14 days of delivery for a replacement or refund. Note that customized items are not eligible for returns unless they arrive with errors.\n\n'
                          '8. Is there a minimum order for custom T-shirts?\n'
                          'No minimum order! Whether you want just one shirt or a bulk order, we’re here to make it happen.\n\n'
                          '9. Do you offer discounts for bulk orders?\n'
                          'Yes, we provide special pricing for bulk orders. Contact our customer service team for details.\n\n'
                          '10. Are your designs eco-friendly?\n'
                          'Yes! We prioritize sustainability by offering organic fabrics and eco-friendly printing processes that minimize waste.',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}