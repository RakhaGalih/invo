// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:invo/model/constant/constant.dart';

class DetailProdukLabel extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const DetailProdukLabel({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: kGreyText,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              label + value,
              style: kRegularTextStyle.copyWith(fontSize: 12, color: kGreyDarkText),
            ),
          )
        ],
      ),
    );
  }
}
