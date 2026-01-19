import 'package:cine_flow/core/utills/app_imports.dart';
import 'package:cine_flow/features/movies/presentation/controllers/splash_contrller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
   Get.put<SplashContrller>(SplashContrller()); 
  }
}
