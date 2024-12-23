import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shirtify/component/SessionManagement.dart';
import 'package:shirtify/pages/AboutPage.dart';
import 'package:shirtify/pages/ChangePassword_Page.dart';
import 'package:shirtify/pages/DisplayProduct.dart';
import 'package:shirtify/pages/FAQPage.dart';
import 'package:shirtify/pages/LoginPage.dart';
import 'package:shirtify/pages/OrdersPage.dart';
import 'package:shirtify/pages/RegisterPage.dart';

import 'component/Colors.dart';
import 'component/Images.dart';
import 'component/bottomnavigation.dart';
import 'database/FirebaseRun.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseRun.run();
  final Sessionmanagement sessionManager = Sessionmanagement();
  final userInfo = await sessionManager.getUserInfo();
  runApp(MyApp(userInfo: userInfo));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? userInfo;
  const MyApp({super.key, this.userInfo});

  @override
  Widget build(BuildContext context) {
    final GoRouter route = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => MyHomePage(title: 'Flutter Demo Home Page', userInfo: userInfo)),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(path: '/signup', builder: (context, state) => const RegisterPage()),
        GoRoute(path: '/bottomnavigation', builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return Bottomnavigation(extra: extra);
        }),
        GoRoute(path: '/displayproduct', builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return DisplayProduct(extra: extra);
        }),
        GoRoute(path: '/changepassword', builder: (context, state) => const ChangePasswordPage()),
        GoRoute(path: '/orders', builder: (context, state) => const Orderspage()),
        GoRoute(path: '/about', builder: (context, state) => const AboutPage()),
        GoRoute(path: '/faq', builder: (context, state) => const Faqpage()),
      ],
    );

    return MaterialApp.router(
      routerConfig: route,
      title: 'AID ANCHOR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Map<String, dynamic>? userInfo;
  final String title;

  const MyHomePage({super.key, required this.title, this.userInfo});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    LoadingEnable();
  }

  void LoadingEnable() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;

        if (Firebase.apps.isEmpty) {
          print('Firebase not initialized');
        } else {
          print('Firebase initialized');
        }

        if (widget.userInfo != null) {
          GoRouter.of(context).go('/bottomnavigation', extra: widget.userInfo);
        } else {
          GoRouter.of(context).go('/login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: ColorsPallete.orange,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 400,
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
                        fontFamily: 'LeagueSpartan',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10), // Adjusted height
              _isLoading
                  ? const SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  color: ColorsPallete.white,
                ),
              )
                  : const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}