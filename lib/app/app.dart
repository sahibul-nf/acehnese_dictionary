import 'package:acehnese_dictionary/app/routes/app_pages.dart';
import 'package:acehnese_dictionary/app/routes/app_routes.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: AppColor.background,
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: AppRoutes.splaceScreen,
      getPages: AppPages.pages,
    );
  }
}