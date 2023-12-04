import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Providers/authentication_provider.dart';
import '../../Styles/colors.dart';
import '../../Utils/message.dart';
import '../../Utils/router.dart';
import '../main_activity.dart';
import '../BottomNavPages/Diagnostics/diagnostics.dart';

class AuthScreenPage extends StatefulWidget {
  const AuthScreenPage({super.key});

  @override
  State<AuthScreenPage> createState() => _AuthScreenPageState();
}

class _AuthScreenPageState extends State<AuthScreenPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            AuthProvider().signInWithGoogle().then((value) {
              if (value.user == null) {
                error(context, message: 'Tente novamente');
              }
              else {
                nextPageOnly(context, const DiagnosticsPage());
              }
            });
          },
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Text('Login'),
            ),
          ),
        ),
      );
  }
}