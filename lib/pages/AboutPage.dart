import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../component/Colors.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
          'About Us',
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
                  const Text(
                    'Welcome to Shirtify—your ultimate destination for stylish, custom-designed T-shirts that speak your vibe! At Shirtify,'
                        ' we believe in turning everyday wear into a canvas for self-expression. Whether you’re looking for bold graphics, minimalist designs,'
                        ' or personalized prints, we’ve got you covered. Made from premium fabrics and crafted for comfort,'
                        ' our T-shirts redefine what it means to wear your personality.Perfect for any occasion, Shirtify brings your unique style to life, one tee at a time!',
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
    );
  }
}