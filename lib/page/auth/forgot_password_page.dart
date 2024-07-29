import 'package:flutter/material.dart';
import 'package:invo/common/customTextField.dart';
import 'package:invo/common/customization.dart';
import 'package:invo/common/input_validator.dart';
import 'package:invo/components/continue_button.dart';
import 'package:invo/components/continue_divider.dart';
import 'package:invo/components/form_header.dart';
import 'package:invo/components/mainButton.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _teleponController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const FormHeader(
                      title: 'Lupa Password',
                      desc:
                          'Masukkan nomor handphone kamu untuk mendapatkan kode OTP'),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                      label: "No Handphone",
                      hintText: "Masukkan nomor telepon",
                      controller: _teleponController,
                      textInputType: TextInputType.phone,
                      isPassword: false,
                      validator: (value) =>
                          InputValidator().emptyValidator(value),
                      isPhone: true),
                  const SizedBox(
                    height: 24,
                  ),
                  const ContinueDivider(),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ContinueButton(
                        icon: IconAssets.facebookIcon,
                        title: 'Facebook',
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: ContinueButton(
                        icon: IconAssets.googleIcon,
                        title: 'Google',
                      )),
                    ],
                  ),
                  const Spacer(),
                  MainButton(title: 'Kirim kode OTP', onTap: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
