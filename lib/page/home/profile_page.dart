import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invo/components/profie_tile.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/page/auth/change_password.dart';
import 'package:invo/service/service_component.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool light = true;
  String? _username;
  String? _email;
  String? _telepon;
  String? _image;

  Future<void> _navigateAndDisplayResult(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/edit');

    // Check what was returned and act accordingly
    if (result != null) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _logOut(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/stepper');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      imageURL: _image ??
                          'https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _username ?? 'null',
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
                          ProfileTile(title: 'Username', value: _username),
                          ProfileTile(title: 'Email', value: _email),
                          ProfileTile(title: 'No Telepon', value: _telepon),
                          const ProfileTile(
                              title: 'Password', value: '••••••••••'),
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
                              _logOut(context);
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
          )
        ],
      ),
    );
  }
}
