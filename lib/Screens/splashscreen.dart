import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Utils/router.dart';
import 'Authentication/auth_page.dart';
import 'BottomNavPages/Diagnostics/diagnostics.dart';
import 'main_activity.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (user == null) {
        nextPageOnly(context, const AuthScreenPage());
      }
      else {
        nextPage(context, DiagnosticsPage());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('img/Logo_FaceView_02.png', width: 250, height: 250),
      ),
    );
  }
}