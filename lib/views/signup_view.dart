import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, this.toggleView});
  final Function()? toggleView;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeLogoUrl = TextEditingController();
  TextEditingController storePhoneController = TextEditingController();
  TextEditingController ownerFullNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final AuthenticationService _auth = locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 35,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 1.5,
              ),
              child: Form(
                child: Column(
                  children: [
                    const Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          'أنشيء حسابك',
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
                            'قم بإنشاء حساب ، وقم بإيصال الطلبات!!',
                            style: kTextRegular16,
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
                      controller: storePhoneController,
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
                    // const SizedBox(
                    //   height: 64,
                    // ),
                    TextFormField(
                      controller: storeNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'إسم المتجر',
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
                      controller: storeLogoUrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'شعار المتجر',
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
                      controller: locationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'موقع المتجر',
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
                      onPressed: () {
                        _auth.signUpWithEmail(
                          email: emailController.text,
                          password: passwordController.text,
                          ownerFullName: ownerFullNameController.text,
                          storeLogoUrl: storeLogoUrl.text,
                          storeName: storeNameController.text,
                          storePhone: storePhoneController.text,
                          location: locationController.text,
                        );
                      },
                      style: kMainButton,
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
    );
  }
}
