import 'package:flutter/material.dart';
import 'package:invo/database/dummy/database.dart';
import 'package:invo/model/constant/constant.dart';

import '../model/dummy/phone_code_model.dart';
import 'customization.dart';

class CustomFormField extends StatefulWidget {
  final int? maxLines;
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool isPassword;
  final bool isPhone;
  final bool isRequired;
  const CustomFormField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller,
      required this.textInputType,
      this.validator,
      this.onChanged,
      this.maxLines,
      this.isPassword = false,
      this.isPhone = false,
      this.isRequired = false});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _isPasswordNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return widget.isPhone
        ? TextFormField(
            controller: widget.controller,
            keyboardType: widget.textInputType,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: widget.isPassword ? _isPasswordNotVisible : false,
            autocorrect: !widget.isPassword,
            enableSuggestions: !widget.isPassword,
            onChanged: widget.onChanged,
            style: CustomFont.poppins(Colors.black, 14, FontWeight.w700),
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE1B064), width: 2),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE2E2E2), width: 2),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              hintText: widget.hintText,
              hintStyle: CustomFont.poppins(
                  const Color(0xFFABABAB), 14, FontWeight.w700),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      splashRadius: 30,
                      onPressed: () {
                        setState(() {
                          _isPasswordNotVisible = !_isPasswordNotVisible;
                        });
                      },
                      icon: _isPasswordNotVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    )
                  : null,
            ),
          )
        : Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(widget.label,
                        style: CustomFont.poppins(
                            const Color(0xFF777777), 12, FontWeight.w500)),
                    if (widget.isRequired)
                      Text(
                        '*',
                        style: kMediumTextStyle.copyWith(
                            fontSize: 12, color: kRed),
                      )
                  ],
                ),
              ),
              TextFormField(
                controller: widget.controller,
                keyboardType: widget.textInputType,
                validator: widget.validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: widget.isPassword ? _isPasswordNotVisible : false,
                autocorrect: !widget.isPassword,
                enableSuggestions: !widget.isPassword,
                onChanged: widget.onChanged,
                style: CustomFont.poppins(Colors.black, 14, FontWeight.w700),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE1B064), width: 2),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE2E2E2), width: 2),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  hintText: widget.hintText,
                  hintStyle: CustomFont.poppins(
                      const Color(0xFFABABAB), 14, FontWeight.w700),
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          splashRadius: 30,
                          onPressed: () {
                            setState(() {
                              _isPasswordNotVisible = !_isPasswordNotVisible;
                            });
                          },
                          icon: _isPasswordNotVisible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        )
                      : null,
                ),
              )
            ],
          );
  }
}
