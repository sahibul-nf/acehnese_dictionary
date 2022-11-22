import 'package:acehnese_dictionary/app/features/features.dart';
import 'package:acehnese_dictionary/app/features/search/search.dart';
import 'package:acehnese_dictionary/app/routes/app_routes.dart';
import 'package:get/route_manager.dart';

import '../features/auth/pages/splace_screen.dart';
import '../features/dictionary/pages/word_detail_page.dart';
import '../features/search/pages/search_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.feat, page: () => const Features()),
    GetPage(name: AppRoutes.splaceScreen, page: () => const SplaceScreen()),
    GetPage(
      name: AppRoutes.search,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(name: AppRoutes.wordDetail, page: () => WordDetailPage()),
  ];
}
