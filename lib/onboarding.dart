import 'package:flutter/material.dart';

class UserOnboardingPage extends StatefulWidget {
  @override
  _UserOnboardingPageState createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<Map<String, String>> onboardingData = [    {      'title': 'Welcome to MyApp',      'subtitle': 'Buy and sell real estate',      'image': 'assets/images/welcome.png',    },    {      'title': 'Awesome Features',      'subtitle': 'We have lots of features',      'image': 'assets/images/features.png',    },    {      'title': 'Get Started',      'subtitle': 'Create your account now',      'image': 'assets/images/get_started.png',    },  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        onboardingData[index]['image']!,
                        height: 250.0,
                      ),
                      SizedBox(height: 32.0),
                      Text(
                        onboardingData[index]['title']!,
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        onboardingData[index]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                _currentPage == onboardingData.length - 1 ? 'Get Started' : 'Next',
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 8.0),
      height: 10.0,
      width: _currentPage == index ? 30.0 : 10.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.green[700] : Colors.grey[400],
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
