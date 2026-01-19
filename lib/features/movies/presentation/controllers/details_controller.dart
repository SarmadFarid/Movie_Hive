import 'package:cine_flow/core/utills/app_imports.dart';

class DetailsController extends GetxController {
  final MovieRepository _repo;
  DetailsController(this._repo);

  late MovieModel movie;
  var isloadingCast = false.obs;
  var isloadingDetails = false.obs;
  var isloadingSimilar = false.obs;
  var isloadingTrailers = false.obs;
  var isloadingRecommended = false.obs;
  var castList = <CastModel>[].obs;
  var movieTrailers = <TrailerModel>[].obs;
  var similarMovies = <MovieModel>[].obs;
  var recommendedmovies = <MovieModel>[].obs;
  Rx<MovieDetailModel?> movieDetails = Rx<MovieDetailModel?>(null);

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      movie = Get.arguments as MovieModel;
    }
    Future.wait([
      fetchMovieCast(movie.id),
      fetchMovieDetails(movie.id),
      fetchSimilarMovies(movie.id),
      fetchMovieTrailers(movie.id),
      fetchRecommendedMovies(movie.id)
    ]);
  }

  Future<void> fetchMovieCast(int id) async {
    isloadingCast.value = true;
    final result = await _repo.getMoviesCast(id);
    result.fold(
      (failure) {
        isloadingCast.value = false;
        log('error : ${failure.message} ');
      },
      (cast) {
        castList.assignAll(cast);
        isloadingCast.value = false;
      },
    );
  }

  Future<void> fetchMovieDetails(int id) async {
    isloadingDetails.value = true;
    final result = await _repo.getMovieDetails(id);
    result.fold(
      (failure) {
        isloadingDetails.value = false;
        log('fetchcing movie detail error : ${failure.message}');
      },
      (details) {
        movieDetails.value = details;
        isloadingDetails.value = false;
      },
    );
  }

  Future<void> fetchSimilarMovies(int id) async {
    isloadingSimilar.value = true;
    final result = await _repo.getSimilarMovies(id);
    result.fold(
      (failure) {
        isloadingSimilar.value = false;
        log('fetching similar movies error: ${failure.message}');
      },
      (movies) {
        similarMovies.assignAll(movies);
        isloadingSimilar.value = false;
      },
    );
  }

  Future<void> fetchMovieTrailers(int id) async {
    isloadingTrailers.value = true;
    final result = await _repo.getMovieTrailers(id);
    result.fold(
      (failure) {
        isloadingTrailers.value = false;
        UiHelpers.showError(failure.message);
      },
      (movies) {
        movieTrailers.assignAll(movies);
        isloadingTrailers.value = false;
      },
    );
  }

  Future<void> fetchRecommendedMovies(int id) async {
    isloadingRecommended.value = true ;
    final result = await _repo.getRecommendedMovies(id);
    result.fold(
      (failure) {
        isloadingRecommended.value = false;
        log(failure.message);
      },
      (movies) {
        recommendedmovies.assignAll(movies);
        isloadingRecommended.value = false;
      },
    );
  }
 
 }
