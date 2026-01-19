import 'package:movie_hive/core/utills/app_imports.dart';
import 'package:movie_hive/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:movie_hive/features/movies/presentation/controllers/search_movie_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieRepository>(() => MoviesRepositoryImpl(), fenix: true);
    Get.lazyPut<SearchMovieController>(
      () => SearchMovieController(Get.find<MovieRepository>()),
    );
  }
}
