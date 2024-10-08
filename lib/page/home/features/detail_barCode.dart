import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:invo/api_config/url.dart';
import 'package:invo/common/customization.dart';
import 'package:invo/components/detail_produk_label.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/model/detailBarCodeModel.dart';

import '../../../model/db/product_dbModel.dart';
import '../../../model/productModel.dart';

class DetailBarCodePage extends StatefulWidget {
  final DetailBarCodeModel data;
  const DetailBarCodePage({super.key, required this.data});

  @override
  State<DetailBarCodePage> createState() => _DetailBarCodePageState();
}

class _DetailBarCodePageState extends State<DetailBarCodePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      widget.data.data.img1,
      widget.data.data.img2,
      widget.data.data.img3
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: CustomSize.height(context, 0.5),
              child: Stack(
                children: [
                  PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                        print(images[index]);
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          "${Url.baseUrl}/images/${images[index]}",
                          height: double.infinity,
                          fit: BoxFit.fitHeight,
                        );
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: CustomSize.height(context, 0.2),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            kBlack.withOpacity(0),
                            kBlack.withOpacity(0.5)
                          ])),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            images.length,
                            (index) => AnimatedContainer(
                              margin: const EdgeInsets.only(right: 6),
                              height: 5,
                              width: (index == _selectedIndex) ? 28 : 12,
                              decoration: BoxDecoration(
                                  color: (index == _selectedIndex)
                                      ? kWhite
                                      : kWhite.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(2.5)),
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.easeInOutQuint,
                            ),
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kBlack.withOpacity(0.35)),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: kWhite,
                                  )),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.data.category,
                    style: kRegularTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.data.data.name,
                    style: kBoldTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Rp. ${widget.data.data.price}',
                    style:
                        kBoldTextStyle.copyWith(fontSize: 16, color: kYellow),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailProdukLabel(
                      label: 'Code: ',
                      value: widget.data.data.productCode,
                      icon: FluentIcons.barcode_scanner_20_regular),
                  DetailProdukLabel(
                      label: 'Location: ',
                      value: widget.data.data.location,
                      icon: FluentIcons.location_20_regular),
                  DetailProdukLabel(
                      label: 'Qty: ',
                      value: widget.data.data.quantity.toString(),
                      icon: FluentIcons.box_20_regular),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Deskripsi',
                    style: kSemiBoldTextStyle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.data.data.description,
                    style: kRegularTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
