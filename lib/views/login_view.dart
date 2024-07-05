import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/views/onboarding_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 35,
            ),
            child: Column(
              children: [
                const Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      'أهلا بك',
                      style: TextStyle(
                        color: kPrimaryText,
                        fontSize: 32.0,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: Text(
                        'قم بتسجيل الدخول ، هنالك كثير من الطلبات بإنتظارك لإيصالها!!',
                        style: TextStyle(
                          color: kSecondaryText,
                          fontSize: 16.0,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'الإسم',
                    labelStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: kSecondaryText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'كلمة السر',
                    labelStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: kSecondaryText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      'هل نسيت كلمة السر؟',
                      style: TextStyle(
                        color: kSecondaryText,
                        fontSize: 16.0,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                ElevatedButton(
                  onPressed: () {},
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
                    'تسجيل دخول',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Text(
                      'هل تريد الإنضمام إلينا ؟',
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
                            builder: (context) => const SignUpOnBoarding(),
                          ),
                        );
                      },
                      child: const Text(
                        'أنشئ حساب',
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
        ),
      ),
    );
  }
}
