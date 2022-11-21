import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final void Function(String)? onChanged;
  const SearchInput({
    required this.textController,
    required this.hintText,
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: onChanged,
      cursorColor: AppColor.primary,
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 20, right: 16),
          child: Icon(
            UniconsLine.search,
            color: Color(0xffB8C3DA),
          ),
        ),
        // suffixIcon: IconButton(
        //   onPressed: () {},
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   icon: const Icon(UniconsLine.search),
        //   color: AppColor.primary,
        // ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xffB8C3DA)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }
}
