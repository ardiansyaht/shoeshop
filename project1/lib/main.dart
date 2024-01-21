import 'package:flutter/material.dart';
import 'package:project1/Pages/intro_pages.dart';
import 'package:project1/Pages/login.dart';
import 'package:project1/Pages/shop_page.dart';
import 'package:project1/components/themenotifier.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: 'AIzaSyBuqc6c9MyBNMNax7I-TZki48BgpqNZJWU',
    authDomain: 'fluttercrud-28197.firebaseapp.com',
    projectId: 'fluttercrud-28197',
    storageBucket: 'fluttercrud-28197.appspot.com',
    messagingSenderId: '253704718154',
    appId: '1:253704718154:android:0ad3d02fb4ad1a702fa3b3',
  ),
);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
