import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/Colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();

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
          'Change password',
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
          child: Container(
            width: 380, // Set the desired width here
            height: 400, // Set the desired height here
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
                const SizedBox(height: 20),
                Text('OLD PASSWORD', style: TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: ColorsPallete.whiteish)),
                const SizedBox(height: 10),
                TextField(
                  controller: oldpasswordController,
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
                    hintText: 'Enter old your password',
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
                Text('NEW PASSWORD', style: TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: ColorsPallete.whiteish)),
                const SizedBox(height: 10),
                TextField(
                  controller: newpasswordController,
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
                    hintText: 'Enter your new password',
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
                          backgroundColor: ColorsPallete.whiteish, // Background color of the button
                        ),
                        child: Text('Update Password',
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
        ),
      ),
    );
  }
}