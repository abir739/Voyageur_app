import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:voyageur_app/provider/sign_in_provider.dart';
import 'package:voyageur_app/screens/home_screen.dart';
import 'package:voyageur_app/screens/login_screen.dart';
import 'package:voyageur_app/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    // create a timer of 2 seconds
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? nextScreen(context, const LoginScreen())
          : nextScreen(context, const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/Logo.svg',
            width: 150, // replace with your desired width
            height: 150, // replace with your desired height
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
