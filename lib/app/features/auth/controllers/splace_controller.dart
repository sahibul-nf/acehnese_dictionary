import 'package:acehnese_dictionary/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SplaceController extends GetxController {
  void startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.feat);
    });
  }

  @override
  void onInit() {
    super.onInit();

    startTimer();
  }
}
