import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GeneralUtils extends GetxController {
  final RxList<String> currencies =
      ['USD', 'PKR', 'INR', 'AED', 'CAD', 'AUD', 'GBP'].obs;
  RxString selectedcurrency = 'USD'.obs;
  RxString selectedcurrencyB = 'PKR'.obs;

  RxString countryflag = 'USD'.obs;

  Rx result = ''.obs;
  void getresult(dynamic value) {
    result.value = value;
  }

  void setcountryflag(String flag) {
    countryflag.value = flag;
  }
}
