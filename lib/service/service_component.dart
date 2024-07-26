import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invo/model/constant/constant.dart';

class MyNetworkImage extends StatelessWidget {
  final String imageURL;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const MyNetworkImage({
    super.key,
    required this.imageURL,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(imageURL, width: width, height: height, fit: fit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CircularProgressIndicator(
              color: kYellow,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          ),
        );
      }
    }, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
      return SizedBox(
          width: width,
          height: height,
          child: const Text('Failed to load image'));
    });
  }
}

class ImageService {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  File? getSelectedImage() {
    return selectedImage;
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    } else {
      print("No image selected");
    }
  }
}
