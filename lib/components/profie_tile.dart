import 'package:flutter/material.dart';
import 'package:invo/model/constant/constant.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String? value;
  const ProfileTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Text(
            title,
            style: kMediumTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(
            width: 40,
          ),
          Expanded(
            child: Text(
              value ?? '-',
              textAlign: TextAlign.end,
              style: kRegularTextStyle.copyWith(
                  fontSize: 12, color: kGreyText),
            ),
          ),
        ],
      ),
    );
  }
}

class IconProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  const IconProfileTile(
      {super.key,
      required this.icon,
      required this.color,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: kMediumTextStyle.copyWith(fontSize: 14, color: color),
          ),
        ],
      ),
    );
  }
}
