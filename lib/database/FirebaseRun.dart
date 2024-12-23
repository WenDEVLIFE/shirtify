import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseRun{
  static Future<void> run() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCUoMDMX-iwG3U30rTlJ-iMOXviAD1JMJA',
        appId: '1:207247085456:android:b5746b2feaa047408a6d15',
        messagingSenderId: '207247085456',
        projectId: 'shirtify-b8c04',
        storageBucket: 'shirtify-b8c04.firebasestorage.app',  // Add this line
      ),
    );

    if (Firebase.apps.isEmpty) {
      Fluttertoast.showToast(msg: "Failed to connect to database", backgroundColor: Colors.red);
    } else {
      Fluttertoast.showToast(msg: "Connected to database", backgroundColor: Colors.green);
    }
  }
}