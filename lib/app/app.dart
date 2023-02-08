import 'package:acehnese_dictionary/app/features/auth/pages/auth_check.dart';
import 'package:acehnese_dictionary/app/routes/app_pages.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:convenient_test/convenient_test.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConvenientTestWrapperWidget(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColor.primary,
          scaffoldBackgroundColor: AppColor.background,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        // initialRoute: AppRoutes.splaceScreen,
        getPages: AppPages.pages,
        home: const AuthCheck(),
      ),
    );
  }
}
