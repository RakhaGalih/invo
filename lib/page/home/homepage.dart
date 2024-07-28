import 'package:flutter/material.dart';
import 'package:invo/model/constant/constant.dart';
import 'package:invo/service/service_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                MyNetworkImage(
                  imageURL: _image ??
                      'https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang,',
                      style: kRegularTextStyle.copyWith(
                          fontSize: 14, color: kGreyText),
                    ),
                    Text(
                      'Mas Dono',
                      style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    prefixIcon:
                        GestureDetector(child: const Icon(Icons.search)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
                    filled: true,
                    fillColor: kLightGrey,
                    hintStyle: const TextStyle(color: kGreyText),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: 'Cari produk'),
                onChanged: (value) async {}),
          ],
        ),
      ),
    );
  }
}
