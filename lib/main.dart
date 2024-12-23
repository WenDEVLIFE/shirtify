import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shirtify/pages/LoginPage.dart';
import 'package:shirtify/pages/RegisterPage.dart';

import 'component/Colors.dart';
import 'component/Images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final GoRouter route = GoRouter(
        routes: [
        GoRoute(path: '/', builder: (context, state) => MyHomePage(title: 'Flutter Demo Home Page')),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
          GoRoute(path: '/signup', builder: (context, state) => const RegisterPage()),

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
  const MyHomePage({super.key, required this.title});
  final String title;

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

        GoRouter.of(context).go('/login');
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
