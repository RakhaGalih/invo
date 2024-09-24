import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invo/common/customTextField.dart';
import 'package:invo/common/input_validator.dart';
import 'package:invo/components/form_header.dart';
import 'package:invo/components/mainButton.dart';
import 'package:invo/model/addProductModel.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/service/service_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_config/api.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/loading.dart';
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
  List<File> productImg = [];
  bool _isLoad = false;

  Future _takePictureGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage;

    try {
      pickedImage = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          preferredCameraDevice: CameraDevice.rear);

      if (pickedImage != null) {
        print("PATH: ${File(pickedImage.path)}");
        print("TYPE: ${File(pickedImage.mimeType.toString())}");
        print("NAME: ${File(pickedImage.name.toString())}");
        setState(() {
          productImg.add(File(pickedImage!.path));
          print(productImg);
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
        print("PATH: ${File(pickedImage.path)}");
        print("TYPE: ${File(pickedImage.mimeType.toString())}");
        print("NAME: ${File(pickedImage.name.toString())}");
        setState(() {
          productImg.add(File(pickedImage!.path));
          print(productImg);
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

  Future add() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isLoad = true;
      });
      AddProductModel model = await Api().addProduct(
          name: _namaController.text,
          category: _kategoriController.text,
          quantity: _quantityController.text,
          price: _hargaController.text,
          productCode: _kodeProdukController.text,
          location: _lokasiController.text,
          description: _deskripsiController.text,
          productImg: productImg,
          token: pref.getString('token_user').toString());
      setState(() {
        _isLoad = false;
      });
      Navigator.pop(context);
    } on HttpException {
      setState(() {
        _isLoad = false;
      });
      return CustomDialog.showAlertDialog(
          context, 'Error', 'Http Exception', 'error');
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      validator: (value) =>
                          InputValidator().emptyValidator(value),
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
                      validator: (value) =>
                          InputValidator().emptyValidator(value),
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
                      validator: (value) =>
                          InputValidator().emptyValidator(value),
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
                      validator: (value) =>
                          InputValidator().emptyValidator(value),
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
                      validator: (value) =>
                          InputValidator().emptyValidator(value),
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
                      validator: (value) =>
                          InputValidator().emptyValidator(value),
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
                      validator: (value) =>
                          InputValidator().emptyValidator(value),
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
                          style: kMediumTextStyle.copyWith(
                              fontSize: 12, color: kRed),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    productImg.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              showOptionImg();
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
                        : Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    showOptionImg();
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: kYellow, width: 2)),
                                    child: const Icon(
                                      Icons.add,
                                      color: kYellow,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: 275,
                                child: Scrollbar(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: productImg.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          productImg.removeAt(index);
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width: 100,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.file(
                                                  productImg[index],
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
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                    const SizedBox(
                      height: 24,
                    ),
                    MainButton(
                        title: 'Tambah Produk',
                        onTap: () async {
                          await add();
                        })
                  ],
                ),
              ),
            ),
          ),
          _isLoad ? const LoadingAnimation() : Container()
        ],
      ),
    );
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
