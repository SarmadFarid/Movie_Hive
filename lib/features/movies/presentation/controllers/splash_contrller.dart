import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class SplashContrller extends GetxController {
  @override
  void onInit() {
    FlutterNativeSplash.remove(); 
    super.onInit();
  }
}