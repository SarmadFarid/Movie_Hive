import 'package:cine_flow/core/utills/app_imports.dart';
import 'package:cine_flow/features/movies/data/repositories/movies_repository_impl.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieRepository>(() => MoviesRepositoryImpl(), fenix: true);
    Get.lazyPut<DetailsController>(
      () => DetailsController(Get.find<MovieRepository>()),
      fenix: true,
    );
  }
}
