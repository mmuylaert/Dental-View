import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import '../firebase_options.dart';
import 'Providers/authentication_provider.dart';
import 'Providers/bottom_new_provider.dart';
import 'Providers/db_provider.dart';
import 'Providers/detch_polls_provider.dart';
import 'Screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => BottomNavProvider()),
          ChangeNotifierProvider(create: (context) => DbProvider()),
          ChangeNotifierProvider(create: (context) => FetchPollsProvider()),
        ],
        child: const MaterialApp(
          home: SplashScreen(),
        )
    );
  }
}