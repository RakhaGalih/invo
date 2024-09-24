import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invo/components/build_main_menu.dart';
import 'package:invo/components/home_top_card.dart';
import 'package:invo/components/mainButton.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/model/refreshModel.dart';
import 'package:invo/page/home/features/add_product.dart';
import 'package:invo/page/home/features/detail_produk.dart';
import 'package:invo/page/home/features/report_product.dart';
import 'package:invo/service/service_component.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_config/api.dart';
import '../../components/alert_dialog.dart';
import '../../components/loading.dart';
import 'features/list_product.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String imageProfile;
  const HomePage({super.key, required this.name, required this.imageProfile});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyNetworkImage(
                          imageURL: widget.imageProfile,
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
                              'Welcome,',
                              style: kRegularTextStyle.copyWith(
                                  fontSize: 14, color: kGreyText),
                            ),
                            Text(
                              widget.name,
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
                            prefixIcon: GestureDetector(
                                child: const Icon(Icons.search)),
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
            ),
          ),
        );
      }),
    );
  }

  Future<void> refresh() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      RefreshModel model = await Api().doRefresh();
      setState(() {
        pref.setString('token_user', model.accessToken);
      });
    } on HttpException {
      return CustomDialog.showAlertDialog(
          context, 'Error', 'Http Exception', 'error');
    } on SocketException {
      return CustomDialog.showAlertDialog(
          context, 'Login Failed', 'No internet connection', 'error');
    } on TimeoutException {
      return CustomDialog.showAlertDialog(context, 'Timeout',
          'There seems to be an internet connection error', 'warning');
    }
  }
}
