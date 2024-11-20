import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moturep/firebase_options.dart';  
import 'screens/login_screen.dart'; 
import 'screens/main_screen.dart'; 
import 'screens/payment_screen.dart';  

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moturep',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(), 
      routes: {
        '/payment': (context) => PaymentScreen(),
      },
      debugShowCheckedModeBanner: false,  
    );
  }
}
