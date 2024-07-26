import 'package:flutter/material.dart';
import 'package:invo/common/customTextField.dart';
import 'package:invo/common/customization.dart';

import '../../common/input_validator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();

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
                    SizedBox(height: CustomSize.height(context, 0.05)),
                    Text("Welcome back,",
                        style: CustomFont.poppins(
                            Colors.black, 16, FontWeight.w700)),
                    SizedBox(height: CustomSize.height(context, 0.01)),
                    Text("Login to continue your inventory!",
                        style: CustomFont.poppins(
                            Colors.black, 12, FontWeight.w400)),
                    SizedBox(height: CustomSize.height(context, 0.05)),
                    CustomFormField(
                        label: "Email",
                        hintText: "Enter your Email",
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        isPassword: false,
                        validator: (value) =>
                            InputValidator().emailValidator(value),
                        isPhone: false),
                    SizedBox(height: CustomSize.height(context, 0.03)),
                    CustomFormField(
                        label: "Username",
                        hintText: "Enter your username",
                        controller: userController,
                        textInputType: TextInputType.name,
                        isPassword: false,
                        validator: (value) =>
                            InputValidator().emptyValidator(value),
                        isPhone: false),
                    SizedBox(height: CustomSize.height(context, 0.03)),
                    CustomFormField(
                        label: "Password",
                        hintText: "Enter your password",
                        controller: passController,
                        textInputType: TextInputType.visiblePassword,
                        isPassword: true,
                        validator: (value) =>
                            InputValidator().emptyValidator(value),
                        isPhone: false),
                    SizedBox(height: CustomSize.height(context, 0.03)),
                    CustomFormField(
                        label: "Confirm Password",
                        hintText: "Confirm your password",
                        controller: passConfirmController,
                        textInputType: TextInputType.visiblePassword,
                        isPassword: true,
                        validator: (value) =>
                            InputValidator().retypePasswordValidator(
                              value,
                              passController.text,
                            ),
                        isPhone: false),
                    SizedBox(height: CustomSize.height(context, 0.03)),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text("Lupa password?",
                            style: CustomFont.poppins(
                                const Color(0xFFE1B064), 12, FontWeight.w700))),
                    SizedBox(height: CustomSize.height(context, 0.03)),
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
                    SizedBox(height: CustomSize.height(context, 0.03)),
                    button2Login(),
                    SizedBox(height: CustomSize.height(context, 0.16)),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: Text(
                          "Masuk",
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
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.call, color: Colors.black),
                SizedBox(width: CustomSize.width(context, 0.03)),
                Text(
                  "No. Phone",
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
