// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:invo/common/customization.dart';
import 'package:invo/model/constant/constant.dart';

class ContinueButton extends StatelessWidget {
  final Widget icon;
  final String title;
  const ContinueButton({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
          icon,
          const SizedBox(width: 8),
          Text(
            title,
            style: kBoldTextStyle.copyWith(fontSize: 14, color: kBlack),
          ),
        ],
      ),
    );
  }
}
