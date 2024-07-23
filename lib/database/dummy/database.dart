import 'package:invo/common/customization.dart';

import '../../model/dummy/phone_code_model.dart';

class DataDummy {
  static List<PhoneCode> countries = [
    PhoneCode(name: "Indonesia", code: "+62", flag: ImageAssets.IND),
    PhoneCode(name: "Japan", code: "+81", flag: ImageAssets.JAP),
    PhoneCode(name: "South Africa", code: "+27", flag: ImageAssets.AFC),
    PhoneCode(name: "America", code: "+1", flag: ImageAssets.USA),
  ];
}
