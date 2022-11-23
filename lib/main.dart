import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app.dart';

void main() async {
  // Initialize Mobile Ads
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();

  // Initialize GetStorage
  await GetStorage.init();

  runApp(const MyApp());
}
