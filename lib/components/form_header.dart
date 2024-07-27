// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:invo/model/constant/constant.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final String desc;
  const FormHeader({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))),
        Text(
          title,
          style: kBoldTextStyle.copyWith(fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: kRegularTextStyle.copyWith(fontSize: 12, color: kGreyText),
          ),
        ),
      ],
    );
  }
}
