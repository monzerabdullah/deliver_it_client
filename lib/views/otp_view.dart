import 'package:deliver_it_client/constants.dart';
import 'package:flutter/material.dart';

class OtpConfirmation extends StatefulWidget {
  const OtpConfirmation({super.key});

  @override
  State<OtpConfirmation> createState() => _OtpConfirmationState();
}

class _OtpConfirmationState extends State<OtpConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                const Text(
                  'أدخل الرمز',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 32.0,
                    color: kPrimaryText,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'أدخل الرمز المكون من أربع أرقام الذي قمنا بإرساله للرقم ',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.0,
                    color: kSecondaryText,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  '+20 1146784805',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22.0,
                    color: kPrimary,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OtpTextField(),
                      OtpTextField(),
                      OtpTextField(),
                      OtpTextField(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    const Text(
                      'لم تستلم الرمز بعد ؟',
                      style: TextStyle(
                        color: kSecondaryText,
                        fontSize: 16.0,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'إعادة إرسال الرمز ',
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
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OtpConfirmation()));
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
                    'تأكيد',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 62,
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: kSecondaryText,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {}
        },
      ),
    );
  }
}
