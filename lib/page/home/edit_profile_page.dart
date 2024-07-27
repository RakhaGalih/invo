import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invo/common/customTextField.dart';
import 'package:invo/components/mainButton.dart';
import 'package:invo/components/secondaryButton.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/service/service_component.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final ImageService _imageService = ImageService();
  final bool _showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _telepon;
  String? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _showSpinner,
      color: kGrey,
      child: Stack(children: [
        SvgPicture.asset(
          'assets/svg/bg.svg',
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 106,
                    ),
                    Center(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: kGrey,
                                  child: (_imageService.selectedImage == null)
                                      ? MyNetworkImage(
                                          imageURL: _image ??
                                              'https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef',
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          _imageService.selectedImage!,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        )),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: kGrey),
                                child: GestureDetector(
                                    onTap: () async {
                                      await _imageService.pickImage();
                                      setState(() {});
                                    },
                                    child: const Icon(Icons.edit)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomFormField(
                        label: "Username",
                        hintText: "Enter your username",
                        controller: _usernameController,
                        textInputType: TextInputType.name,
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an username';
                          }
                          return null;
                        },
                        isPhone: false),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormField(
                        label: "No Handphone",
                        hintText: "Masukkan nomor telepon",
                        controller: _teleponController,
                        textInputType: TextInputType.phone,
                        isPassword: false,
                        validator: (value) {
                          String pattern = r'^\+62\d{9,11}$';
                          RegExp regex = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          } else if (!regex.hasMatch(value)) {
                            return 'Please enter a valid phone number (+62xxxxxxxxxx)';
                          }
                          return null;
                        },
                        isPhone: true),
                    const Spacer(),
                    SafeArea(
                      top: false,
                      child: Column(
                        children: [
                          MainButton(title: 'simpan', onTap: () {}),
                          const SizedBox(
                            height: 20,
                          ),
                          SecondaryButton(
                              title: 'Batal',
                              onTap: () {
                                Navigator.pop(context, 'update');
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ]),
    ));
  }
}
