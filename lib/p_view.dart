import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view/main.dart';
import 'main_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  final String title;
  final String description;
  final String imageUrl;
  final IconData iconData;

  Data({
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.iconData,
  });
}

class PView extends StatefulWidget {
  @override
  _PViewState createState() => _PViewState();
}

class _PViewState extends State<PView> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  int _currentIndex = 0;
  final List<Data> myData = [
    Data(
      title: "title 1",
      description: " description for image 1",
      imageUrl: "images/q1.jpg",
      iconData: Icons.add_a_photo,
    ),
    Data(
      title: "title 2",
      description: " description for image 2",
      imageUrl: "images/q2.jpg",
      iconData: Icons.attach_money,
    ),
    Data(
      title: "title 3",
      description: " description for image 3",
      imageUrl: "images/q3.jpg",
      iconData: Icons.access_time,
    ),
    Data(
      title: "title 4",
      description: " description for image 4",
      imageUrl: "images/q4.jpg",
      iconData: Icons.account_box,
    ),
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 6), (timer) {
      if (_currentIndex < 3) _currentIndex++;

      _controller.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/a': (ctx) => MyHomePage(),
        '/b': (ctx) => MainSplashScreen(),
      },
      home: Scaffold(
        body: Stack(
          children: [
            Builder(
              builder: (ctx) => PageView(
                controller: _controller,
                children: myData
                    .map((item) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: ExactAssetImage(item.imageUrl),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item.iconData,
                                size: 130,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                item.title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                item.description,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                onPageChanged: (val) {
                  setState(() {
                    _currentIndex = val;
                    // if (_currentIndex == 3) {
                    //   Future.delayed(Duration(seconds: 2),
                    //       () => Navigator.of(ctx).pushNamed('/b'));
                    // }
                  });
                },
              ),
            ),
            Indicator(_currentIndex),
            Builder(
              builder: (ctx) => Align(
                alignment: Alignment(0, 0.93),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: RaisedButton(
                    padding: EdgeInsets.all(6),
                    color: Colors.red,
                    child: Text(
                      "GET STARTED",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onPressed: () async {
                      Navigator.of(ctx).pushReplacementNamed('/b');
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setBool('x', true);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(index == 0 ? Colors.green : Colors.red),
          buildContainer(index == 1 ? Colors.green : Colors.red),
          buildContainer(index == 2 ? Colors.green : Colors.red),
          buildContainer(index == 3 ? Colors.green : Colors.red),
        ],
      ),
    );
  }

  Container buildContainer(Color color) {
    return Container(
      margin: EdgeInsets.all(4),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
