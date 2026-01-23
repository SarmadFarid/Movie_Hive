 
import 'package:cine_flow/core/utills/app_imports.dart';

 

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<StorageServices>(() => StorageServiceImpl(), fenix: true);
    Get.lazyPut<MovieRepository>(() => MoviesRepositoryImpl(), fenix: true);
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<MovieRepository>()
         
      ),
      fenix: true,
    );
  }
}
