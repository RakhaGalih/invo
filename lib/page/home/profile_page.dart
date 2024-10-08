import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invo/components/profie_tile.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/model/logoutModel.dart';
import 'package:invo/page/auth/change_password.dart';
import 'package:invo/service/service_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_config/api.dart';
import '../../components/alert_dialog.dart';
import '../../components/loading.dart';
import '../../database/db/userDB.dart';
import '../../model/db/user_dbModel.dart';
import '../../model/refreshModel.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String username;
  final String noTelp;
  final String imageProfile;
  const ProfilePage(
      {super.key,
      required this.name,
      required this.email,
      required this.username,
      required this.noTelp,
      required this.imageProfile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool light = true;
  bool _isLoad = false;

  Future<void> _navigateAndDisplayResult(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/edit');
    if (result != null) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future _logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isLoad = true;
      });
      LogoutModel model = await Api().logout();
      await pref.clear();
      setState(() {
        _isLoad = false;
      });
      Navigator.pushReplacementNamed(context, '/stepper');
    } on HttpException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(context, 'Error',
          'Failed to login, check the username or password again', 'error');
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
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/svg/bg.svg',
                  width: MediaQuery.of(context).size.width,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 130,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: CircleAvatar(
                          radius: 60,
                          backgroundColor: kGrey,
                          child: MyNetworkImage(
                            imageURL: widget.imageProfile,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kMediumTextStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Profile',
                                style: kMediumTextStyle.copyWith(fontSize: 14),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  await _navigateAndDisplayResult(context);
                                },
                                child: Text('Edit Profil',
                                    style: kRegularTextStyle.copyWith(
                                        fontSize: 14, color: kYellow)),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: kGrey, width: 1)),
                            child: Column(
                              children: [
                                ProfileTile(
                                    title: 'Username', value: widget.username),
                                ProfileTile(
                                    title: 'Email', value: widget.email),
                                ProfileTile(
                                    title: 'No Telepon', value: widget.noTelp),
                              ],
                            ),
                          ),
                          Text(
                            'Lainnya',
                            style: kMediumTextStyle.copyWith(fontSize: 14),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: kGrey, width: 1)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const IconProfileTile(
                                      title: 'Notifikasi',
                                      color: kBlack,
                                      icon: Icons.notifications_outlined,
                                    ),
                                    const Spacer(),
                                    Switch(
                                      // This bool value toggles the switch.
                                      value: light,
                                      activeColor: kYellow,
                                      onChanged: (bool value) {
                                        // This is called when the user toggles the switch.
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChangePassword(
                                                    isFromProfile: true)));
                                  },
                                  child: const IconProfileTile(
                                    title: 'Ganti Password',
                                    color: kBlack,
                                    icon: Icons.lock,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _logOut();
                                  },
                                  child: const IconProfileTile(
                                    title: 'Logout',
                                    color: kRed,
                                    icon: Icons.logout,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                _isLoad ? const LoadingAnimation() : Container(),
              ],
            ),
          ),
        ),
      );
    });
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
