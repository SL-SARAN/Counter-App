import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mycounter/ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'My Counter', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    // Create and load banner ad
    AdHelper.createBannerAd();
  }

  @override
  void dispose() {
    // Dispose banner ad when widget is disposed
    AdHelper.disposeBannerAd();
    super.dispose();
  }

  void _increment() {
    setState(() {
      _count += 1;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) {
        _count -= 1;
      }
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = screenWidth * 0.1;
    final responsiveIconSize = screenWidth * 0.07;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 99, 196, 245),
                Color(0xFF764ba2),
                Color(0xFF8E2DE2),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              Text(
                'Simple Counter',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding),
                child: SizedBox(
                  height: screenHeight * 0.3,
                  child: FittedBox(
                    child: Text(
                      '$_count',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.2,
                child: Padding(
                  padding: EdgeInsets.only(top: padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: _decrement,
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          '- Decrease',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: _increment,
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: Colors.greenAccent,
                        ),
                        child: Text(
                          '+ Increase',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: _reset,
                        icon: Icon(
                          Icons.refresh_rounded,
                          size: responsiveIconSize,
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        label: Text(
                          'Reset',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              AdHelper.getBannerAdWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
