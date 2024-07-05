import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/views/login_view.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
                      'أنشيء حسابك',
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
                        'قم بإنشاء حساب ، وقم بإيصال الطلبات!!',
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
                    labelText: 'الإسم الرباعي',
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'رقم الهاتف',
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
                    'أنشيء حسابك',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  textDirection: TextDirection.rtl,
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
        ),
      ),
    );
  }
}
