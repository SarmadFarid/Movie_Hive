import 'package:get/get.dart';
import 'package:movie_hive/core/services/storage_service_impl.dart';
import 'package:movie_hive/core/services/storage_services.dart';
import 'package:movie_hive/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:movie_hive/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_hive/features/movies/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageServices>(() => StorageServiceImpl(), fenix: true);
    Get.lazyPut<MovieRepository>(() => MoviesRepositoryImpl(), fenix: true);
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<MovieRepository>(),
        Get.find<StorageServices>(),
      ),
      fenix: true,
    );
  }
}
