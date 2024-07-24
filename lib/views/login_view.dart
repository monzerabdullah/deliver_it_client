import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, this.toggleView});
  final Function()? toggleView;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthenticationService _auth = locator<AuthenticationService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height * 0.15,
                ),
                child: Column(
                  children: [
                    const Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          'أهلا بك',
                          style: kTextRegular32,
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
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'البريد',
                        labelStyle: TextStyle(
                          fontFamily: 'Cairo',
                          color: kSecondaryText,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
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
                          'نسيت كلمة السر؟',
                          style: TextStyle(
                            color: kSecondaryText,
                            fontSize: 16.0,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        _auth.loginWithEmail(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                      style: kMainButton,
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
                          onPressed: widget.toggleView,
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
        ),
      ),
    );
  }
}
