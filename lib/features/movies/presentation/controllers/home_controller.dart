import 'package:cine_flow/core/utills/app_imports.dart';

class HomeController extends GetxController {
  final MovieRepository _repo;
  // final StorageServices _storageService;
  HomeController(this._repo,);

  var isloading = false.obs;
  var isloadingTopRated = false.obs;
  var isloadingupComming = false.obs;
  var isloadingNowPlaying = false.obs;
  var isloadingPopularmovies = false.obs;
  var trendingMovies = <MovieModel>[].obs;
  var topRatedMovies = <MovieModel>[].obs;
  var popularMovies = <MovieModel>[].obs;
  Rx<UpcommingMoviesModel?> upcommingMovies = Rx<UpcommingMoviesModel?>(null);
  Rx<UpcommingMoviesModel?> nowPlayingMoveis = Rx<UpcommingMoviesModel?>(null);

  @override
  void onReady() {
    Future.wait([
      fetchTrendingMovies(),
      getTopRatedMovies(),
      getUpcommingMovies(),
      getNowPlayingMovies(),
      fetchPopularMovies(),
    ]);
    super.onReady();
  }

  Future<void> fetchTrendingMovies() async {
    isloading.value = true;
    final result = await _repo.getTrendingMovies();
    result.fold(
      (failure) {
        isloading.value = false;
        UiHelpers.showError(failure.message);
      },
      (movies) async {
        trendingMovies.assignAll(movies);
        isloading.value = false;
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    isloadingPopularmovies.value = true ;
    final result = await _repo.getPopularMovies();
    result.fold(
      (failure) {
        isloadingPopularmovies.value = false;
        log(failure.message);
      },
      (movies) {
        popularMovies.assignAll(movies);
        isloadingPopularmovies.value = false;
      },
    );
  }

  Future<void> getTopRatedMovies() async {
    isloadingTopRated.value = true;

    final apiResult = await _repo.getTopRatedMovies();
    apiResult.fold(
      (failure) {
        isloadingTopRated.value = false;
        UiHelpers.showError(failure.message);
      },
      (movies) async {
        isloadingTopRated.value = false;
        topRatedMovies.assignAll(movies);
      },
    );
  }

  Future<void> getUpcommingMovies() async {
    isloadingupComming.value = true;
    final result = await _repo.getUpcommingMovies();
    result.fold(
      (failure) {
        isloadingupComming.value = false;
        log(failure.message);
      },
      (movie) {
        upcommingMovies.value = movie;
        isloadingupComming.value = false;
      },
    );
  }

  Future<void> getNowPlayingMovies() async {
    isloadingNowPlaying.value = true;
    final result = await _repo.getNowPlayingMovies();
    result.fold(
      (failure) {
        isloadingNowPlaying.value = false;
        log(failure.message);
      },
      (movie) {
        nowPlayingMoveis.value = movie;
        isloadingNowPlaying.value = false;
      },
    );
  }
}
