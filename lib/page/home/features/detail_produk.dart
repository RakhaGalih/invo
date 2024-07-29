import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:invo/common/customization.dart';
import 'package:invo/components/detail_produk_label.dart';
import 'package:invo/model/constant/constant.dart';

class DetailProdukPage extends StatefulWidget {
  const DetailProdukPage({super.key});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  int _selectedIndex = 0;
  final List<String> _images = [
    'assets/image/ban.jpg',
    'assets/image/ban2.jpg',
    'assets/image/ban3.jpg'
  ];
  @override
  Widget build(BuildContext context) {
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
                      itemCount: _images.length,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                        print(_images[index]);
                      },
                      itemBuilder: (context, index) {
                        return Image.asset(
                          _images[index],
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
                            _images.length,
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
                    'Lokomotif',
                    style: kRegularTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Accelera 651 Sport TW 200',
                    style: kBoldTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Rp. 20.000',
                    style:
                        kBoldTextStyle.copyWith(fontSize: 16, color: kYellow),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const DetailProdukLabel(
                      label: 'Code: ',
                      value: 'SE4602',
                      icon: FluentIcons.barcode_scanner_20_regular),
                  const DetailProdukLabel(
                      label: 'Location: ',
                      value: 'Bandung, Indonesia',
                      icon: FluentIcons.location_20_regular),
                  const DetailProdukLabel(
                      label: 'Qty: ',
                      value: '2',
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
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit. ',
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
