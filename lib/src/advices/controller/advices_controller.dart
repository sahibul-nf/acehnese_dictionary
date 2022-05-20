import 'dart:convert';
import 'dart:developer';

import 'package:acehnese_dictionary/src/advices/model/advices.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

class AdvicesController extends GetxController {
  final _advices = <Advices>[].obs;
  get advices => _advices;

  getAdvices(String word) async {
    var url = Uri.parse(
        "https://aceh-dictionary.herokuapp.com/api/v1/advices?input=$word");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var map = jsonDecode(response.body);
        var data = map['data'];
        for (var json in (data as List)) {
          var advice = Advices.fromJson(json);
          _advices.addIf(_advices.length < 5, advice);
        }
      }
    } on GetHttpException catch (e) {
      log("An error occured", error: e);
    }
  }
}
