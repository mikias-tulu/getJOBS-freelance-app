import 'package:freelance_app/screens/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 400]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imageFlex: 2,
        imagePadding: EdgeInsets.zero //(top: 100),
        );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('logo.png', 60),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange)),
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Welcome to a world of new possibilities!",
          body: "",
          image: _buildImage('Dream_jobs.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Unlock Endless opportunities",
          body: "Stay up-to-date with the latest job postings",
          image: _buildImage('opportunities.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "getJOBS get the job done!",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on ", style: bodyStyle),
              Icon(Icons.post_add_outlined),
              Text(" to post a job", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 3,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('productivity.jpg'),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(
        Icons.arrow_back,
        color: Colors.orange,
      ),
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.orange)),
      next: const Icon(Icons.arrow_forward, color: Colors.orange),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.orange)),
      curve: Curves.bounceIn, //Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        activeColor: Colors.orange,
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Color.fromARGB(221, 58, 56, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
