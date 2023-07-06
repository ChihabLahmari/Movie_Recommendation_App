import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/color_manager.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/constants.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), () {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    });
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primary,
      child: Center(
        child: Lottie.asset(JsonAssets.splashNetflix),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
