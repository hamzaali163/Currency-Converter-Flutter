import 'package:currency_converter_app_flutter/model/currencyresult_model.dart';
import 'package:currency_converter_app_flutter/repository/converstion_respository.dart';
import 'package:currency_converter_app_flutter/utils/general_utils.dart';
import 'package:get/get.dart';

class ConverstionViewModel {
  final repo = ConverstionRespository();
  Future<CurrencyResultModel> fetchapiresult(
      String countryA, String countryB, int total) async {
    final result = await repo.fetchapiresult(countryA, countryB, total);

    return result;
  }
}
