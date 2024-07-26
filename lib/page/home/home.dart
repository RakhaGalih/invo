import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:invo/components/navbar_icon.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/model/dummy/navicon.dart';
import 'package:invo/model/provider/data_model.dart';
import 'package:invo/page/home/homepage.dart';
import 'package:invo/page/home/profile_page.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(builder: (context, data, child) {
      List<Widget> widgetOptions = <Widget>[
        const HomePage(),
        const ProfilePage(),
      ];
      return Scaffold(
        body: widgetOptions[data.selectedNavBar],
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).padding.bottom + 80,
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
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          navIcons.length,
                          (index) => NavBarIcon(
                                isActive: data.selectedNavBar == index,
                                index: index,
                                color: kYellow,
                                icon: navIcons[index].icon,
                                activeIcon: navIcons[index].activeIcon!,
                                title: navIcons[index].title,
                              ))),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
