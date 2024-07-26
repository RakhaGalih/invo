import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../common/customization.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: CustomSize.height(context, 0.05)),
                Text("Enter OTP code",
                    style:
                        CustomFont.poppins(Colors.black, 16, FontWeight.w700)),
                SizedBox(height: CustomSize.height(context, 0.01)),
                Text(
                    "Enter the OTP code has been sent to the number +62 88967452301",
                    textAlign: TextAlign.center,
                    style:
                        CustomFont.poppins(Colors.black, 12, FontWeight.w400)),
                SizedBox(height: CustomSize.height(context, 0.03)),
                _otpInput(),
                SizedBox(height: CustomSize.height(context, 0.03)),
                RichText(
                  text: TextSpan(
                    text: "Haven't received a code yet? ",
                    style: CustomFont.poppins(
                        const Color(0xFF777777), 12, FontWeight.w400),
                    children: [
                      TextSpan(
                        text: "Resend (00.56)",
                        style: CustomFont.poppins(
                            const Color(0xFFC6C6C6), 12, FontWeight.w700),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => print('Tap Here onTap'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _otpInput() {
    return Pinput(
      onCompleted: (value) => Navigator.pop(context),
      // onSubmitted: (value) => Navigator.pop(context),
      length: 6,
      pinAnimationType: PinAnimationType.slide,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: PinTheme(
        width: CustomSize.width(context, 0.2),
        height: CustomSize.height(context, 0.07),
        textStyle: CustomFont.poppins(Colors.black, 16, FontWeight.w700),
        decoration: const BoxDecoration(),
      ),
      showCursor: true,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: CustomSize.width(context, 0.2),
            height: CustomSize.height(context, 0.003),
            decoration: BoxDecoration(
              color: const Color(0xFFE1B064),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
      preFilledWidget: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: CustomSize.width(context, 0.2),
            height: CustomSize.height(context, 0.003),
            decoration: BoxDecoration(
              color: const Color(0xFFE2E2E2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
      submittedPinTheme: PinTheme(
        width: CustomSize.width(context, 0.2),
        height: CustomSize.height(context, 0.07),
        textStyle: CustomFont.poppins(Colors.black, 16, FontWeight.w700),
        decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFFE1B064), width: 2)),
        ),
      ),
    );
  }
}
