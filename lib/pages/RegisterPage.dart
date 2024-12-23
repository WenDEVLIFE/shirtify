import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/Colors.dart';
import '../component/Images.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscureText1 = true;
  bool obscureText2 = true;

  void togglePasswordVisibility1() {
    setState(() {
      obscureText1 = !obscureText1;
    });
  }

  void togglePasswordVisibility2() {
    setState(() {
      obscureText2 = !obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsPallete.orange, // Set the background color here
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.logoPath),
                      fit: BoxFit.cover, // Adjust this to control how the image fits
                    ),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'SHIRTIFY',
                        style: TextStyle(
                          fontSize: 40,
                          color: ColorsPallete.white, // Color for "AID"
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 450, // Set the desired width here
                  height: 630, // Set the desired height here
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Center(
                        child: Text('SIGN UP', style: TextStyle(fontSize: 30, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: ColorsPallete.black)),
                      ),
                      const SizedBox(height: 20),
                      const Text('EMAIL', style: TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: ColorsPallete.black)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: ColorsPallete.whitegray, // Set the background color here
                          border: OutlineInputBorder(),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                            color: Colors.black, // Set the hint text color here
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black, // Set the text color here
                          fontSize: 16, // Set the text size here
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('PASSWORD', style: TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: ColorsPallete.black)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorsPallete.whitegray, // Set the background color here
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText1 ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: togglePasswordVisibility1,
                          ),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(
                            color: Colors.black, // Set the hint text color here
                          ),
                        ),
                        obscureText: obscureText1,
                        style: const TextStyle(
                          color: Colors.black, // Set the text color here
                          fontFamily: 'Roboto',
                          fontSize: 16, // Set the text size here
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('CONFIRM PASSWORD', style: TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: ColorsPallete.black)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorsPallete.whitegray, // Set the background color here
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText2 ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: togglePasswordVisibility2,
                          ),
                          hintText: 'Enter your confirm password',
                          hintStyle: const TextStyle(
                            color: Colors.black, // Set the hint text color here
                          ),
                        ),
                        obscureText: obscureText2,
                        style: const TextStyle(
                          color: Colors.black, // Set the text color here
                          fontFamily: 'Roboto',
                          fontSize: 16, // Set the text size here
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                            child: ElevatedButton(
                              onPressed: () {
                                // call the controller

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsPallete.orange, // Background color of the button
                              ),
                              child: const Text('Sign Up',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: ColorsPallete.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0), // Add 20 pixels of space on the left
                        child: Align(
                          alignment: const Alignment(0.0, 0.0), // Center align
                          child: GestureDetector(
                            onTap: () {
                            },
                            child: Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorsPallete.orange, // Color for "AID"
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0), // Add 20 pixels of space on the left
                        child: Align(
                          alignment: const Alignment(0.0, 0.0), // Center align
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Sign in here',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorsPallete.orange, // Color for "AID"
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}