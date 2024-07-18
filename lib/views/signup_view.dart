import 'package:deliver_it_client/constants.dart';

import 'package:deliver_it_client/viewmodels/signup_view_model.dart';

import 'package:deliver_it_client/widgets/busy_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key, this.toggleView});
  Function()? toggleView;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // final mqHeight = MediaQuery.of(context).size.height;
  SignUpViewModel model = SignUpViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (context) => model,
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 35,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height * 0.15,
                    ),
                    child: Form(
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
                          TextFormField(
                            decoration: const InputDecoration(
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
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
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
                          TextFormField(
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
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              await model.signUp(
                                  email: emailController.text,
                                  password: passwordController.text);
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
                              'أنشيء حسابك',
                            ),
                          ),

                          // BusyButton(
                          //   title: 'أنشيء حسابك',
                          //   busy: model.busy,
                          //   onPressed: () async {
                          //     await model.signUp(
                          //         email: emailController.text,
                          //         password: passwordController.text);
                          //     // model.setBusy(false);
                          //   },
                          // ),
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
                                onPressed: widget.toggleView,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
