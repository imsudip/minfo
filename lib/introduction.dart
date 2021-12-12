import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:qoutes/homepage.dart';
import 'package:qoutes/styles.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => Homepage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
        child: Container(
      // width: 250,
      child: Stack(
        children: [
          Positioned.fill(
              child: Center(
                  child: Container(
                      height: MediaQuery.of(context).size.width * 0.9,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Lottie.asset('assets/ripples.json',
                          repeat: true, fit: BoxFit.contain)))),
          Positioned.fill(
            child: Center(
              child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                      child: Lottie.asset('assets/$assetName.json',
                          repeat: true))),
            ),
          )
        ],
      ),

      //Lottie.asset('assets/$assetName.json', repeat: true)),
      alignment: Alignment.center,
    ));
  }

  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: headline.copyWith(color: black),
      bodyTextStyle: subtitle1.copyWith(color: black),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome to Minfo",
          body: "Stay updated with latest news in less than 60 words",
          image: Container(
            child: Stack(
              children: [
                Positioned.fill(
                    child: Center(
                        child:
                            Lottie.asset('assets/ripples.json', repeat: true))),
                Positioned.fill(
                  child: Center(
                    child: Container(
                        height: 80,
                        width: 80,
                        child: Center(
                          child: Image.asset(
                            'assets/icon.png',
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Explore",
          body: "Explore news from different categories",
          image: _buildImage('explore'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Minimalist User experience",
          body: "Swipe from right to left to read new Articles",
          image: _buildImage('userX'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Share",
          body: "Double Tap on the Article to share it to your friends",
          image: _buildImage('dtap'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
