import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assignment/features/provider/home_screen_provider.dart';
import 'package:assignment/features/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: MaterialApp(
        title: 'MyMovies App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(), // Keep SplashScreen as the first screen
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
