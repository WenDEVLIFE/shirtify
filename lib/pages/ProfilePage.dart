import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/Colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: ColorsPallete.orange,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Colors.transparent, // Set the background color here
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 460, // Adjust the width based on available space
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                     image: DecorationImage(
                       image: AssetImage('assets/images/shopbg.jpg'),
                       fit: BoxFit.cover, // Adjust this to control how the image fits
                     ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100, // Adjust the width as needed
                          height: 100, // Adjust the height as needed
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // Make the container circular
                            border: Border.all(color: ColorsPallete.orange, width: 2), // Optional border
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/icons/logo.png', // Replace with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 24,
                            color: ColorsPallete.whiteish,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    icon: Icons.key,
                    text: 'CHANGE PASSWORD',
                    onTap: () {
                      print('Account Settings clicked');
                      context.push('/changepassword');
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    icon: Icons.notifications,
                    text: 'ORDERS',
                    onTap: () {
                      print('Notification clicked');
                      context.push('/orders');
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    icon: Icons.question_mark_outlined,
                    text: 'FAQS',
                    onTap: () {
                      print('FAQS clicked');
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildMenuItem(
                    icon: Icons.info_rounded,
                    text: 'ABOUT',
                    onTap: () {
                      print('About clicked');
                      context.push('/about');
                    },
                  ),
                  const SizedBox(height: 80),
                  Center(
                    child: Container(
                      width: constraints.maxWidth * 0.5, // Adjust the width based on available space
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Background color of the TextField
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.transparent), // Border color
                      ),
                      child: ButtonTheme(
                        minWidth: 100, // Adjust the width as needed
                        height: 100, // Adjust the height as needed
                        child: ElevatedButton(
                          onPressed: () {
                            // call the controller
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsPallete.orange, // Background color of the button
                          ),
                          child: const Text(
                            'SIGN OUT',
                            style: TextStyle(
                              fontSize: 24,
                              color: ColorsPallete.white,
                              fontFamily: 'LeagueSpartan',
                              fontWeight: FontWeight.w900,
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
    );
  }

  Widget _buildMenuItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: ColorsPallete.orange,
                  size: 40,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorsPallete.orange,
                      fontFamily: 'LeagueSpartan',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ColorsPallete.orange,
                  size: 40,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              color: ColorsPallete.whitegray, // Color of the line
              thickness: 5, // Thickness of the line
              indent: 20, // Left indent
              endIndent: 20, // Right indent
            ),
          ],
        ),
      ),
    );
  }
}