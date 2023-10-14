import 'package:flutter/material.dart';

import '../../../Providers/authentication_provider.dart';
import '../../../Styles/colors.dart';
import '../../../Utils/message.dart';
import '../../../Utils/router.dart';
import '../../Authentication/auth_page.dart';
import '../../main_activity.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            AuthProvider().logout().then((value) {
              if (value == false) {
                error(context, message: "Tente novamente");
              }
              else {
                nextPageOnly(context, const AuthScreenPage());
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
            child: const Text("Logout"),
          ),
        ),
      ),
    );
  }
}