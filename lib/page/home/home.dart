import 'dart:async';
import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:invo/api_config/url.dart';
import 'package:invo/components/navbar_icon.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/model/detailBarCodeModel.dart';
import 'package:invo/model/dummy/navicon.dart';
import 'package:invo/model/provider/data_model.dart';
import 'package:invo/model/userModel.dart';
import 'package:invo/page/home/features/detail_barCode.dart';
import 'package:invo/page/home/homepage.dart';
import 'package:invo/page/home/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../api_config/api.dart';
import '../../components/alert_dialog.dart';
import '../../components/loading.dart';
import '../../model/refreshModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<NavIcon> navIcons = [
    const NavIcon(
        icon: FluentIcons.home_20_regular,
        activeIcon: FluentIcons.home_20_filled,
        title: 'Home'),
    const NavIcon(
        icon: FluentIcons.person_20_regular,
        activeIcon: FluentIcons.person_20_filled,
        title: 'Profile'),
  ];
  String name = "null";
  String nameHome = "null";
  String email = "-";
  String username = "-";
  String noTelp = "-";
  String imageProfile =
      "https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef";
  bool _isLoad = false;

  Future getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isLoad = true;
      });
      UserModel model =
          await Api().getUser(token: pref.getString('token_user').toString());
      setState(() {
        name = model.name;
        nameHome = model.name;
        email = model.email;
        username = model.username;
        noTelp = model.phoneNumber;
        imageProfile = "${Url.baseUrl}/images/${model.img}";
        print("IMAGE PROFILE: ${Url.baseUrl}/images/${model.img}");
        _isLoad = false;
      });
    } on HttpException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(
          context, 'Error', 'Http Exception', 'error');
    } on SocketException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(
          context, 'Login Failed', 'No internet connection', 'error');
    } on TimeoutException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(context, 'Timeout',
          'There seems to be an internet connection error', 'warning');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, data, child) {
      List<Widget> widgetOptions = <Widget>[
        HomePage(name: nameHome, imageProfile: imageProfile),
        ProfilePage(
            name: name,
            email: email,
            username: username,
            noTelp: noTelp,
            imageProfile: imageProfile)
      ];
      return Scaffold(
        body: Stack(
          children: [
            widgetOptions[data.selectedNavBar],
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).padding.bottom + 94,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: kGrey, width: 2.0),
                  ),
                ),
                child: Material(
                  color: kWhite,
                  child: InkWell(
                    onTap: () {},
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 12),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                navIcons.length,
                                (index) => Padding(
                                      padding: EdgeInsets.only(
                                        right: (index == 0) ? 20 : 0,
                                        left: (index == 0) ? 0 : 20,
                                      ),
                                      child: NavBarIcon(
                                        isActive: data.selectedNavBar == index,
                                        index: index,
                                        color: kYellow,
                                        icon: navIcons[index].icon,
                                        activeIcon: navIcons[index].activeIcon!,
                                        title: navIcons[index].title,
                                      ),
                                    ))),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SimpleBarcodeScannerPage(
                                    scanType: ScanType.barcode,
                                    isShowFlashIcon: true),
                          ));
                      await searchProduct(res.toString());
                    },
                    child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kYellow,
                        ),
                        child: const Icon(
                          FluentIcons.barcode_scanner_20_filled,
                          size: 36,
                          color: kWhite,
                        )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Scan',
                    style: kMediumTextStyle.copyWith(
                        fontSize: 14, color: kGreyText),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 12,
                  )
                ],
              ),
            ),
            _isLoad ? const LoadingAnimation() : Container(),
          ],
        ),
      );
    });
  }

  Future searchProduct(String code) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isLoad = true;
      });
      RefreshModel refresh = await Api().doRefresh();
      await pref.setString('token_user', refresh.accessToken);
      DetailBarCodeModel model = await Api().getDetailBarCode(
          token: pref.getString('token_user').toString(), code: code);
      setState(() {
        _isLoad = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailBarCodePage(data: model)));
    } on HttpException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(
          context, 'Error', 'Http Exception', 'error');
    } on SocketException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(
          context, 'Login Failed', 'No internet connection', 'error');
    } on TimeoutException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(context, 'Timeout',
          'There seems to be an internet connection error', 'warning');
    }
  }
}
