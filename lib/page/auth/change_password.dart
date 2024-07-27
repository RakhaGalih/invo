// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:invo/common/customTextField.dart';
import 'package:invo/components/form_header.dart';
import 'package:invo/components/mainButton.dart';

class ChangePassword extends StatefulWidget {
  final bool isFromProfile;
  const ChangePassword({
    super.key,
    required this.isFromProfile,
  });

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const FormHeader(
                      title: 'Ganti Password',
                      desc: 'Ganti Password dengan yang baru'),
                  const SizedBox(
                    height: 16,
                  ),
                  if(widget.isFromProfile)
                  CustomFormField(
                    label: "Password Lama",
                    hintText: "Masukkan password lama",
                    controller: _oldPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    isPhone: false,
                  ),
                  if(widget.isFromProfile)
                  const SizedBox(
                    height: 24,
                  ),
                  CustomFormField(
                    label: "Password Baru",
                    hintText: "Masukkan password baru",
                    controller: _newPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    isPhone: false,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomFormField(
                    label: "Konfirmasi Password",
                    hintText: "Masukkan password baru",
                    controller: _confirmPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    isPhone: false,
                  ),
                  const Spacer(),
                  MainButton(title: 'Ganti Password', onTap: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
