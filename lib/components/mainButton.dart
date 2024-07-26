// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:invo/common/customization.dart';
import 'package:invo/model/constant/constant.dart';

class MainButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const MainButton({
    super.key,
    required this.title, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          backgroundColor: kYellow,
          padding: const EdgeInsets.symmetric(vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: CustomFont.poppins(Colors.white, 14, FontWeight.w700),
        ),
      ),
    );
  }
}
