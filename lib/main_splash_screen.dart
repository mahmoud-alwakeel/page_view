import 'main.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
class MainSplashScreen extends StatefulWidget {
  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(
          backgroundColor: Colors.blueAccent,
          photoSize: 180,
          image: Image.asset("images/s1.jpg"),
          seconds: 3,
          navigateAfterSeconds: MyHomePage(),
          title: Text("splash screen tutorial 1"),
          loaderColor: Colors.yellow,
          loadingText: Text("getting page ready!"),

        ),
      ),
    );
  }
}
