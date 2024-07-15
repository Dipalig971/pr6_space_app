import 'package:flutter/material.dart';
import 'package:pr6_space_app/screen/space_app/provider/fav_provider.dart';
import 'package:pr6_space_app/screen/space_app/provider/space_provider.dart';
import 'package:pr6_space_app/screen/space_app/view/home/home_screen.dart';
import 'package:pr6_space_app/screen/space_app/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SpaceProvider(),),
    ChangeNotifierProvider(create: (context) => FavoriteProvider(),),
  ],
  builder: (context, child) => const SpaceApp()));
}

class SpaceApp extends StatelessWidget {
  const SpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => const SplashScreen(),
        '/home':(context) => const HomeScreen(),
      },
    );
  }
}
