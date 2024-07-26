import 'package:flutter/material.dart';
import 'package:invo/common/customization.dart';
import 'package:invo/model/constant/constant.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const SecondaryButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: kYellow, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: CustomFont.poppins(kYellow, 14, FontWeight.w700),
        ),
      ),
    );
  }
}
