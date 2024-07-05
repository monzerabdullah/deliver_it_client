import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/views/login_view.dart';
import 'package:deliver_it_client/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'images/svgs/support.svg',
            width: 299,
          ),
          const SizedBox(
            height: 160,
          ),
          const Text(
            'دعم متوفر كل الوقت',
            style: TextStyle(
              color: kPrimaryText,
              fontSize: 32.0,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'لو واجهت أي مشكلة ، بضغطة زر  وفريق دعم وصلها يكون جاهز لمساعدتك',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kSecondaryText,
                fontSize: 16.0,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
