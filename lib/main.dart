import 'package:flutter/material.dart';
import 'package:pfe_test_app/screens/cartScreen.dart';
import 'package:provider/provider.dart';  
import 'onboarding_screen.dart';
import 'login_screen.dart'; 
import 'screens/main_navigation.dart';  
import 'providers/basket_provider.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', 
      routes: {
        '/': (context) => OnboardingScreen(), 
        '/login': (context) => LoginScreen(), 
        '/cart':(context) => CartScreen(),
        '/main': (context) => MainNavigation(), 
      },
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (context) => BasketProvider(),  
          child: child!, 
        );
      },
    );
  }
}
