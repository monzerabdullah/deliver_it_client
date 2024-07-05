import 'dart:async';

import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/views/introScreens/intro1.dart';
import 'package:deliver_it_client/views/introScreens/intro2.dart';
import 'package:deliver_it_client/views/introScreens/intro3.dart';
import 'package:deliver_it_client/views/login_view.dart';
import 'package:deliver_it_client/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SignUpOnBoarding extends StatefulWidget {
  const SignUpOnBoarding({super.key});

  @override
  State<SignUpOnBoarding> createState() => _SignUpOnBoardingState();
}

class _SignUpOnBoardingState extends State<SignUpOnBoarding> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(seconds: 3),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 500,
              child: PageView(
                controller: _pageController,
                children: const [
                  IntroScreen1(),
                  IntroScreen2(),
                  IntroScreen3(),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.02),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: kPrimaryText,
                dotColor: kSecondaryText,
                dotHeight: 12,
                dotWidth: 12,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpView(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 16,
                      ),
                      minimumSize: const Size.fromHeight(60),
                    ),
                    child: const Text(
                      'إنضم إلينا',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'إذا كان لديك حساب قم',
                        style: TextStyle(
                          color: kSecondaryText,
                          fontSize: 16.0,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          );
                        },
                        child: const Text(
                          'بتسجيل الدخول',
                          style: TextStyle(
                            fontSize: 16,
                            color: kPrimary,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
