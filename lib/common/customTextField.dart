import 'package:flutter/material.dart';
import 'package:invo/database/dummy/database.dart';

import '../model/dummy/phone_code_model.dart';
import 'customization.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool isPassword;
  final bool isPhone;
  const CustomFormField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller,
      required this.textInputType,
      this.validator,
      this.onChanged,
      this.isPassword = false,
      this.isPhone = false});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _isPasswordNotVisible = true;
  PhoneCode selectedCountry =
      DataDummy.countries.firstWhere((country) => country.code == "+62");

  @override
  Widget build(BuildContext context) {
    return widget.isPhone
        ? Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.label,
                    style: CustomFont.poppins(
                        const Color(0xFF777777), 12, FontWeight.w500)),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<PhoneCode>(
                      iconSize: 0.0,
                      underline: const SizedBox.shrink(),
                      value: selectedCountry,
                      items: DataDummy.countries.map((PhoneCode country) {
                        return DropdownMenuItem<PhoneCode>(
                          value: country,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                  width: 24, height: 24, child: country.flag),
                              const SizedBox(width: 10),
                              Text(country.code),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (PhoneCode? newValue) {
                        setState(() {
                          selectedCountry = newValue!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      keyboardType: widget.textInputType,
                      validator: widget.validator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText:
                          widget.isPassword ? _isPasswordNotVisible : false,
                      autocorrect: !widget.isPassword,
                      enableSuggestions: !widget.isPassword,
                      onChanged: widget.onChanged,
                      style:
                          CustomFont.poppins(Colors.black, 14, FontWeight.w700),
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFE1B064), width: 2),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFE2E2E2), width: 2),
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
                                    _isPasswordNotVisible =
                                        !_isPasswordNotVisible;
                                  });
                                },
                                icon: _isPasswordNotVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              )
                            : null,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        : Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.label,
                    style: CustomFont.poppins(
                        const Color(0xFF777777), 12, FontWeight.w500)),
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
