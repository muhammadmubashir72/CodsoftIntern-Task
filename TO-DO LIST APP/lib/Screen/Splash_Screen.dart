// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo/widget/BottomBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void switchToSignInPage() {
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => const HomeScreen()));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Bottombar()));
  }

  @override
  void initState() {
    // Timer(Duration(seconds: 10),() => switchToLoginPage());
    Future.delayed(const Duration(seconds: 3), switchToSignInPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey  ,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/icon.png",
            width: 260,
            height: 220,
          )
        ]),
      ),
    );
  }
}
