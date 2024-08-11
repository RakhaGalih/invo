import 'package:flutter/material.dart';
import 'package:invo/model/constant/constant.dart';

class BuildMainMenu extends StatelessWidget {
  final String imagePath;
  final String label;
  final Widget page;
  const BuildMainMenu(
      {super.key,
      required this.imagePath,
      required this.label,
      required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => page)),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: Offset(0, 2)),
              ],
            ),
            child: Image.asset(imagePath, width: 75, height: 75),
          ),
        ),
        const SizedBox(height: 12),
        Text(label, style: kMediumTextStyle.copyWith(fontSize: 14)),
      ],
    );
  }
}
