import 'dart:convert';

import 'package:currency_converter_app_flutter/model/currencyresult_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ConverstionRespository {
  Future<CurrencyResultModel> fetchapiresult(
      String countryA, String countryB, int total) async {
    String exchangeapilink =
        'https://v6.exchangerate-api.com/v6/2785e2830d0cf6f5473f278/pair/${countryA}/${countryB}/${total}';
    print(countryA);
    print(countryB);
    print(total);

    final result = await http.get(Uri.parse(exchangeapilink));
    print(result.toString());

    if (result.statusCode == 200) {
      final body = await jsonDecode(result.body);
      return CurrencyResultModel.fromJson(body);
    } else {
      throw Get.snackbar('error', 'No result found');
    }
  }
}
