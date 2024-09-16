import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:invo/components/navbar_icon.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/model/dummy/navicon.dart';
import 'package:invo/model/provider/data_model.dart';
import 'package:invo/page/home/features/add_product.dart';
import 'package:invo/page/home/homepage.dart';
import 'package:invo/page/home/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../database/db/userDB.dart';
import '../../model/db/user_dbModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userDatabase = UserDatabase.instance;
  String? _username;
  String? _email;
  int? _telepon;
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

  Future<String?> getLoggedInUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loggedInUserEmail');
  }

  Future<void> loadProfileData() async {
    String? email = await getLoggedInUserEmail();

    if (email != null) {
      UserData? user = await userDatabase.getUserByEmail(email);

      if (user != null) {
        setState(() {
          _username = user.username;
          _email = user.email;
          _telepon = user.number;
        });
      }
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, data, child) {
      List<Widget> widgetOptions = <Widget>[
        const HomePage(),
        ProfilePage(email: _email, username: _username, telepon: _telepon),
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
            )
          ],
        ),
      );
    });
  }
}
