import 'package:acehnese_dictionary/core/color.dart';
import 'package:acehnese_dictionary/core/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/splace_controller.dart';

class SplaceScreen extends StatelessWidget {
  const SplaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splaceController = Get.put(SplaceController());

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Acehnese',
                  style: AppTypography.fontStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                      color: AppColor.primary),
                ),
                Text(
                  'Dictionary',
                  style: AppTypography.fontStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          // Loading
          Align(
            alignment: const Alignment(0, 0.8),
            child: LoadingAnimationWidget.inkDrop(
              color: AppColor.primary.withOpacity(0.9),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
