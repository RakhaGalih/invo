import 'package:flutter/material.dart';
import 'package:invo/components/build_main_menu.dart';
import 'package:invo/components/home_top_card.dart';
import 'package:invo/components/mainButton.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/page/home/features/add_product.dart';
import 'package:invo/page/home/features/detail_produk.dart';
import 'package:invo/page/home/features/report_product.dart';
import 'package:invo/service/service_component.dart';

import 'features/list_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                MyNetworkImage(
                  imageURL: _image ??
                      'https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang,',
                      style: kRegularTextStyle.copyWith(
                          fontSize: 14, color: kGreyText),
                    ),
                    Text(
                      'Mas Dono',
                      style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    prefixIcon:
                        GestureDetector(child: const Icon(Icons.search)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
                    filled: true,
                    fillColor: kLightGrey,
                    hintStyle: const TextStyle(color: kGreyText),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: 'Cari produk'),
                onChanged: (value) async {}),
            const SizedBox(
              height: 25,
            ),
            const HomeTopCard(),
            const SizedBox(
              height: 25,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildMainMenu(
                    imagePath: 'assets/image/add.png',
                    label: 'Add',
                    page: AddProductPage()),
                BuildMainMenu(
                    imagePath: 'assets/image/product.png',
                    label: 'Product',
                    page: ListProductPage()),
                BuildMainMenu(
                    imagePath: 'assets/image/report.png',
                    label: 'Report',
                    page: ReportProductPage()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
