import 'package:flutter/material.dart';
import 'package:invo/common/customTextField.dart';
import 'package:invo/common/input_validator.dart';
import 'package:invo/components/form_header.dart';
import 'package:invo/components/mainButton.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/service/service_component.dart';

import '../../../database/db/productDB.dart';
import '../../../model/db/product_dbModel.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _kodeProdukController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final productDatabase = ProductDatabase.instance;
  ProductList? product;
  final ImageService _imageService = ImageService();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormHeader(
                    title: 'Tambah Produk', desc: 'Tambahkan produk anda'),
                const SizedBox(
                  height: 16,
                ),
                CustomFormField(
                  label: "Nama",
                  hintText: "Masukkan nama produk",
                  controller: _namaController,
                  textInputType: TextInputType.name,
                  isRequired: true,
                  validator: (value) => InputValidator().emptyValidator(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFormField(
                  label: "Kategori (Max. 3)",
                  hintText: "Masukkan kategori produk",
                  controller: _kategoriController,
                  textInputType: TextInputType.name,
                  isRequired: true,
                  validator: (value) => InputValidator().emptyValidator(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFormField(
                  label: "Jumlah Produk",
                  hintText: "Masukkan jumlah produk",
                  controller: _quantityController,
                  textInputType: TextInputType.number,
                  isRequired: true,
                  validator: (value) => InputValidator().emptyValidator(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFormField(
                  label: "Kode Produk",
                  hintText: "Masukkan kode produk",
                  controller: _kodeProdukController,
                  textInputType: TextInputType.name,
                  isRequired: true,
                  validator: (value) => InputValidator().emptyValidator(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFormField(
                  label: "Harga (Rupiah)",
                  hintText: "Masukkan harga produk",
                  controller: _hargaController,
                  textInputType: TextInputType.number,
                  isRequired: true,
                  validator: (value) => InputValidator().emptyValidator(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFormField(
                  label: "Lokasi",
                  hintText: "Masukkan lokasi produk",
                  controller: _lokasiController,
                  textInputType: TextInputType.name,
                  isRequired: true,
                  validator: (value) => InputValidator().emptyValidator(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomFormField(
                  maxLines: 3,
                  label: "Deskripsi",
                  hintText: "Masukkan deskripsi produk",
                  controller: _deskripsiController,
                  textInputType: TextInputType.multiline,
                  isRequired: true,
                  validator: (value) => InputValidator().emptyValidator(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Text(
                      "Foto Produk",
                      style: kMediumTextStyle.copyWith(
                          fontSize: 12, color: kGreyDarkText),
                    ),
                    Text(
                      '*',
                      style:
                          kMediumTextStyle.copyWith(fontSize: 12, color: kRed),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                (_imageService.selectedImage == null)
                    ? GestureDetector(
                        onTap: () async {
                          await _imageService.pickImage();
                          setState(() {});
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: kYellow, width: 2)),
                          child: const Icon(
                            Icons.add,
                            color: kYellow,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _imageService.clearImage();
                          setState(() {});
                        },
                        child: SizedBox(
                          width: 100,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _imageService.selectedImage!,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Icon(
                                    Icons.delete,
                                    size: 16,
                                    color: kWhite,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 24,
                ),
                MainButton(
                    title: 'Tambah Produk',
                    onTap: () async {
                      product = ProductList(
                          nameProduct: _namaController.text,
                          category: _kategoriController.text,
                          quantity: int.parse(_quantityController.text),
                          codeProduct: _kodeProdukController.text,
                          price: _hargaController.text,
                          location: _lokasiController.text,
                          desc: _deskripsiController.text,
                          image: _imageService.selectedImage!.path);
                      await productDatabase.create(product!);
                      if (context.mounted) Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
