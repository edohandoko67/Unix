import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../routes/pages.dart';

class AnimatedController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void onInit() {
    super.onInit();

    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Use Get.toNamed for navigation
        Get.toNamed(Routes.STARTED);
      }
    });

    _animationController.forward();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  Animation<double> get animation => _animation;
  }