import 'package:invo/common/customization.dart';

import '../../model/dummy/phone_code_model.dart';
import '../../model/dummy/product.dart';
import '../../model/dummy/report_product_chart.dart';

class DataDummy {
  static List<PhoneCode> countries = [
    PhoneCode(office: "Jakarta", code: "+62", flag: ImageAssets.IND),
    PhoneCode(office: "Tokyo", code: "+81", flag: ImageAssets.JAP),
    PhoneCode(office: "Cape Town", code: "+27", flag: ImageAssets.AFC),
    PhoneCode(office: "Washington D.C", code: "+1", flag: ImageAssets.USA),
  ];

  static List<ChartData> chartData = [
    ChartData(0, 750, 500),
    ChartData(1, 700, 1000),
    ChartData(2, 250, 750),
    ChartData(3, 400, 500),
    ChartData(4, 300, 300),
    ChartData(5, 900, 200),
    ChartData(6, 450, 600),
    ChartData(7, 500, 500),
    ChartData(8, 650, 450),
    ChartData(9, 600, 800),
  ];

  static List<Product> products = [
    Product(
      name: 'AFG Motor oil 350ml',
      imagePath: 'assets/image/oil.png',
      soldCount: 10,
      stock: 22,
    ),
    Product(
      name: 'Accelera 651 Sport TW 200',
      imagePath: 'assets/image/ban.png',
      soldCount: 10,
      stock: 2,
    ),
    Product(
      name: 'RR Motorcycle Exhaust 12V',
      imagePath: 'assets/image/exhaust.png',
      soldCount: 10,
      stock: 0,
    ),
  ];

  static List<ProductData> productData = [
    ProductData(0, 800, 320, '140.000'),
    ProductData(1, 500, 25, '95.000'),
    ProductData(2, 15, 950, '45.000'),
    ProductData(3, 220, 650, '185.000'),
    ProductData(4, 720, 200, '210.000'),
    ProductData(5, 280, 170, '130.000'),
    ProductData(6, 950, 190, '55.000'),
  ];
}
