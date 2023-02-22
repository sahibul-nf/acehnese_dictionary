import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Mobile Ads
  // MobileAds.instance.initialize();

  // set full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Initialize GetStorage
  await GetStorage.init();

  runApp(const MyApp());
}
