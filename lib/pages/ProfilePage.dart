import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/Colors.dart';
import '../component/SessionManagement.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late String email;
  late String id;
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    LoadUser();
  }

  Future<void> LoadUser() async {
    final Sessionmanagement _sessionManager = Sessionmanagement();
    userInfo = (await _sessionManager.getUserInfo())!;
    setState(() {
      email = userInfo['email'];
      id = userInfo['id'];
      print('Email: $email');
      print('ID: $id');
    });
  }

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
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 460,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/shopbg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorsPallete.orange, width: 2),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/icons/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (userInfo.isNotEmpty) // Check if userInfo is initialized
                          Text(
                            "$email",
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
                      width: constraints.maxWidth * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            // call the controller
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsPallete.orange,
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
              color: ColorsPallete.whitegray,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }
}