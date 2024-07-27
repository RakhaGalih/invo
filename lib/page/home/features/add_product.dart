import 'package:flutter/material.dart';
import 'package:invo/common/customTextField.dart';
import 'package:invo/components/form_header.dart';
import 'package:invo/components/mainButton.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
                  
                  const Spacer(),
                  MainButton(title: 'Tambah Produk', onTap: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}