import 'package:flutter/material.dart';
import 'package:invo/page/auth/otp_page.dart';

import '../../common/customTextField.dart';
import '../../common/customization.dart';
import '../../common/input_validator.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text("Welcome back,",
                        style: CustomFont.poppins(
                            Colors.black, 16, FontWeight.w700)),
                    SizedBox(height: CustomSize.height(context, 0.01)),
                    Text("Enter your mobile number to get the OTP code",
                        textAlign: TextAlign.center,
                        style: CustomFont.poppins(
                            Colors.black, 12, FontWeight.w400)),
                    SizedBox(height: CustomSize.height(context, 0.05)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Cell phone number",
                          style: CustomFont.poppins(
                              const Color(0xFF777777), 12, FontWeight.w500)),
                    ),
                    SizedBox(height: CustomSize.height(context, 0.01)),
                    CustomFormField(
                        label: "Cell phone number",
                        hintText: "Enter your phone number",
                        controller: phoneController,
                        textInputType: TextInputType.phone,
                        isPassword: false,
                        validator: (value) =>
                            InputValidator().emptyValidator(value),
                        isPhone: true),
                    SizedBox(height: CustomSize.height(context, 0.05)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            child: Divider(color: Color(0xFFE2E2E2))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "or continue with",
                            style: CustomFont.poppins(
                                const Color(0xFF777777), 12, FontWeight.w400),
                          ),
                        ),
                        const Expanded(
                            child: Divider(color: Color(0xFFE2E2E2))),
                      ],
                    ),
                    SizedBox(height: CustomSize.height(context, 0.05)),
                    button2Login(),
                    SizedBox(height: CustomSize.height(context, 0.31)),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE1B064),
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OtpPage()));
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: CustomFont.poppins(
                              Colors.white, 14, FontWeight.w700),
                        ),
                      ),
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

  Widget button2Login() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: CustomSize.width(context, 0.42),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconAssets.facebookIcon,
                    SizedBox(width: CustomSize.width(context, 0.03)),
                    Text(
                      "Facebook",
                      style:
                          CustomFont.poppins(Colors.black, 14, FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: CustomSize.width(context, 0.42),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconAssets.googleIcon,
                    SizedBox(width: CustomSize.width(context, 0.03)),
                    Text(
                      "Google",
                      style:
                          CustomFont.poppins(Colors.black, 14, FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: CustomSize.height(context, 0.03)),
        SizedBox(
          width: CustomSize.width(context, 0.42),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.email, color: Colors.black),
                SizedBox(width: CustomSize.width(context, 0.03)),
                Text(
                  "Email",
                  style: CustomFont.poppins(Colors.black, 14, FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
