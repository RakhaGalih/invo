import 'package:flutter/material.dart';
import 'package:invo/model/constant/constant.dart';

class ContinueDivider extends StatelessWidget {
  const ContinueDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(child: Divider(color: kGreyText)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("or continue with",
              style:
                  kRegularTextStyle.copyWith(fontSize: 12, color: kGreyText)),
        ),
        const Expanded(child: Divider(color: kGreyText)),
      ],
    );
  }
}
