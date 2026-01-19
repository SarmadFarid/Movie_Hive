import 'package:movie_hive/core/utills/app_imports.dart';

class HomeController extends GetxController {
  final MovieRepository _repo;
  final StorageServices _storageService;
  HomeController(this._repo, this._storageService);

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
  void onInit() {
    Future.wait([
      fetchTrendingMovies(),
      getTopRatedMovies(),
      getUpcommingMovies(),
      getNowPlayingMovies(),
      fetchPopularMovies(),
    ]);
    super.onInit();
  }

  Future<void> fetchTrendingMovies() async {
    if (_storageService.hasData) {
      final cahcedMovies = await _storageService.fetchCachedTrendingMovies();
      cahcedMovies.fold((failure) => null, (movies) {
        trendingMovies.assignAll(movies);
      });
    } else {
      isloading.value = true;
    }

    final result = await _repo.getTrendingMovies();

    result.fold(
      (failure) {
        isloading.value = false;
        if (trendingMovies.isEmpty) {
          UiHelpers.showError(failure.message);
        } else {
          UiHelpers.showSuccess("Offline Mood !");
        }
      },
      (movies) async {
        trendingMovies.assignAll(movies);
        isloading.value = false;
        final savedResult = await _storageService.cacheTrendingMovies(movies);
        savedResult.fold(
          (failure) {
            log("Cache save failed : ${failure.message}");
          },
          (success) {
            log("cache save successfully");
          },
        );
      },
    );
  }

  Future<void> fetchPopularMovies() async {
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
    if (_storageService.hasTopRatedMovies) {
      final cacheMovies = await _storageService.fetchCachedTopRatedMovies();
      cacheMovies.fold(
        (failure) {
          log('fetching cahce top rated movies error ${failure.message}');
        },
        (movies) {
          topRatedMovies.assignAll(movies);
        },
      );
    } else {
      isloadingTopRated.value = true;
    }

    final apiResult = await _repo.getTopRatedMovies();
    apiResult.fold(
      (failure) {
        isloading.value = false;
        if (topRatedMovies.isEmpty) {
          UiHelpers.showError(failure.message);
        } else {
          UiHelpers.showSuccess("Offline Mood!");
        }
      },
      (movies) async {
        isloading.value = false;
        topRatedMovies.assignAll(movies);
        final result = await _storageService.cacheTopRatedMovies(movies);
        result.fold(
          (failure) {
            log('Save Cache top rated movies error : ${failure.message}');
          },
          (success) {
            log('Save cache top rated movies Successfully');
          },
        );
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
