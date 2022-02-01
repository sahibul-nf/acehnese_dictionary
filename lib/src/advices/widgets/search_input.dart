import 'package:acehnese_dictionary/src/admob/admob_controller.dart';
import 'package:acehnese_dictionary/src/advices/controller/advices_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:unicons/unicons.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  SearchInput({required this.textController, required this.hintText, Key? key})
      : super(key: key);

  final advicesController = Get.put(AdvicesController());
  final admobController = Get.find<AdmobController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: textController,
        onChanged: (value) {
          //Do something wi
          advicesController.advices.clear();
          if (advicesController.advices.isEmpty) {
            advicesController.getAdvices(value);
          }
          admobController.loadInterstitialAd();
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            UniconsLine.search,
            color: Color(0xffB8C3DA),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xffB8C3DA)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
