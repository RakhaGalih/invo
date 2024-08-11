import 'package:flutter/material.dart';

import '../model/constant/constant.dart';

class HomeTopCard extends StatelessWidget {
  const HomeTopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current activity period',
                style: kRegularTextStyle.copyWith(
                    fontSize: 12, color: const Color(0xFF7F7F7F)),
              ),
              Text(
                'Aug 01 - 31, 2024',
                style: kMediumTextStyle.copyWith(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Stock', style: kMediumTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 8.0),
                  Text('14', style: kMediumTextStyle.copyWith(fontSize: 32)),
                ],
              ),
              Column(
                children: [
                  Text('In', style: kMediumTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 8.0),
                  Text('4', style: kMediumTextStyle.copyWith(fontSize: 32)),
                ],
              ),
              Column(
                children: [
                  Text('Out', style: kMediumTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 8.0),
                  Text('2', style: kMediumTextStyle.copyWith(fontSize: 32)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
