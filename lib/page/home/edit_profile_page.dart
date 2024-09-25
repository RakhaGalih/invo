import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invo/common/customTextField.dart';
import 'package:invo/components/mainButton.dart';
import 'package:invo/components/secondaryButton.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/model/updateModel.dart';
import 'package:invo/service/service_component.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_config/api.dart';
import '../../api_config/url.dart';
import '../../common/customization.dart';
import '../../components/alert_dialog.dart';
import '../../components/loading.dart';
import '../../database/db/userDB.dart';
import '../../database/dummy/database.dart';
import '../../model/db/user_dbModel.dart';
import '../../model/dummy/phone_code_model.dart';
import '../../model/refreshModel.dart';
import '../../model/userModel.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  File? profileImg;
  final bool _showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String _image =
      "https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef";
  bool _isLoad = false;
  PhoneCode selectedCountry =
      DataDummy.countries.firstWhere((country) => country.office == "Jakarta");
  String selectedOffice = "Jakarta";

  Future _takePictureGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage;

    try {
      pickedImage = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          preferredCameraDevice: CameraDevice.rear);

      if (pickedImage != null) {
        print("PATH: " + File(pickedImage.path).toString());
        print("TYPE: " + File(pickedImage.mimeType.toString()).toString());
        print("NAME: " + File(pickedImage.name.toString()).toString());
        setState(() {
          profileImg = File(pickedImage!.path);
          print(profileImg);
        });
      } else {
        Navigator.pop(context);
        await ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No image was selected"),
          ),
        );
      }
    } catch (e) {
      print(e);
      print("error");
    }
  }

  Future _takePictureCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage;

    try {
      pickedImage = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          preferredCameraDevice: CameraDevice.front);

      if (pickedImage != null) {
        print("PATH: " + File(pickedImage.path).toString());
        print("TYPE: " + File(pickedImage.mimeType.toString()).toString());
        print("NAME: " + File(pickedImage.name.toString()).toString());
        setState(() {
          profileImg = File(pickedImage!.path);
          print(profileImg);
        });
      } else {
        Navigator.pop(context);
        await ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No image was selected"),
          ),
        );
      }
    } catch (e) {
      print(e);
      print("error");
    }
  }

  Future getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isLoad = true;
      });
      UserModel model =
          await Api().getUser(token: pref.getString('token_user').toString());
      if (model.username != "-" &&
          model.phoneNumber != "-" &&
          model.officeAddress != "-") {
        setState(() {
          _usernameController.text = model.username;
          _teleponController.text = model.phoneNumber;
          selectedOffice = model.officeAddress;
          selectedCountry = DataDummy.countries
              .firstWhere((country) => country.office == model.officeAddress);
        });
      }
      setState(() {
        _image = "${Url.baseUrl}/images/${model.img}";
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
          context, 'Update Failed', 'No internet connection', 'error');
    } on TimeoutException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(context, 'Timeout',
          'There seems to be an internet connection error', 'warning');
    }
  }

  Future updateUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isLoad = true;
      });
      RefreshModel refresh = await Api().doRefresh();
      await pref.setString('token_user', refresh.accessToken);
      UpdateUserModel model = await Api().updateUser(
          token: pref.getString('token_user').toString(),
          phoneNumber: _teleponController.text,
          officeAddress: selectedOffice,
          file: profileImg!);
      setState(() {
        _isLoad = false;
      });
      Navigator.pop(context, 'update');
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
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            ModalProgressHUD(
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
                                          child: (profileImg == null)
                                              ? MyNetworkImage(
                                                  imageURL: _image,
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  File(profileImg!.path),
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
                                            shape: BoxShape.circle,
                                            color: kGrey),
                                        child: GestureDetector(
                                            onTap: () {
                                              showOptionImg();
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("No Handphone",
                                  style: CustomFont.poppins(
                                      const Color(0xFF777777),
                                      12,
                                      FontWeight.w500)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF0F0F0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<PhoneCode>(
                                    iconSize: 0.0,
                                    underline: const SizedBox.shrink(),
                                    value: selectedCountry,
                                    items: DataDummy.countries
                                        .map((PhoneCode country) {
                                      return DropdownMenuItem<PhoneCode>(
                                        value: country,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: country.flag),
                                            const SizedBox(width: 10),
                                            Text(country.code),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (PhoneCode? newValue) {
                                      setState(() {
                                        selectedCountry = newValue!;
                                        selectedOffice = newValue.office;
                                        print(
                                            "OFFICE SELECTED: $selectedOffice");
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: CustomFormField(
                                      label: "No Handphone",
                                      hintText: "Masukkan nomor telepon",
                                      controller: _teleponController,
                                      textInputType: TextInputType.phone,
                                      isPassword: false,
                                      validator: (value) {
                                        String pattern = r'^08\d{10}$';
                                        RegExp regex = RegExp(pattern);
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter phone number';
                                        } else if (!regex.hasMatch(value)) {
                                          return 'Please enter a valid phone number (08xxxxxxxxxx)';
                                        }
                                        return null;
                                      },
                                      isPhone: true),
                                ),
                              ],
                            ),
                            const Spacer(),
                            SafeArea(
                              top: false,
                              child: Column(
                                children: [
                                  MainButton(
                                      title: 'simpan',
                                      onTap: () async {
                                        await updateUser();
                                      }),
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
            ),
            _isLoad ? const LoadingAnimation() : Container(),
          ],
        ));
  }

  showOptionImg() {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Galeri'),
                onTap: () {
                  _takePictureGallery(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _takePictureCamera(context);
                },
              ),
            ],
          );
        });
  }
}
