import 'package:flutter/material.dart';
import 'package:invo/components/mainButton.dart';
import 'package:invo/components/secondaryButton.dart';
import 'package:invo/components/stepper_carousel.dart';
import 'package:invo/model/constant/constant.dart';

class StepperPage extends StatelessWidget {
  const StepperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: StepperCarousel(),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  MainButton(
                      title: 'Login',
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  SecondaryButton(
                      title: 'Sign Up',
                      onTap: () {
                        Navigator.pushNamed(context, '/signUp');
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: kRegularTextStyle.copyWith(
                              fontSize: 12, color: kGreyText),
                          children: [
                            const TextSpan(
                                text:
                                    "Dengan masuk atau mendaftar, kamu menyetujui "),
                            TextSpan(
                                text: "Persyaratan Layanan",
                                style:
                                    kRegularTextStyle.copyWith(color: kYellow)),
                            const TextSpan(text: " & "),
                            TextSpan(
                                text: "Kebijakan Privasi",
                                style:
                                    kRegularTextStyle.copyWith(color: kYellow)),
                            const TextSpan(text: " kami."),
                          ])),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
