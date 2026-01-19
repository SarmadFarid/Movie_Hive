import 'package:movie_hive/core/utills/app_imports.dart';

class SearchMovieController extends GetxController {
  final MovieRepository _repo;
  SearchMovieController(this._repo);

  final searchTextController = TextEditingController();
  var searchResult = <MovieModel>[].obs;
  var searchText = "".obs;
  var errorMessage = "".obs;
  var iserror = false.obs;
  var isloadingSearch = false.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(searchText, (query) {
      if (query.toString().isNotEmpty) {
        searchMovie(query);
      } else {
        searchResult.clear();
      }
    }, time: const Duration(milliseconds: 600));
  }

  Future<void> searchMovie(String query) async {
    isloadingSearch.value = true;
    final result = await _repo.searchMovies(query);
    result.fold(
      (failure) {
        isloadingSearch.value = false;
        iserror.value = true;
        errorMessage.value = failure.message;
      },
      (movies) {
        isloadingSearch.value = false;
        if (movies.isEmpty) {
          searchResult.clear();
          errorMessage.value = "No Data";
        } else {
          searchResult.assignAll(movies);
        }
      },
    );
  }

  Future<void> clearSearch() async {
    searchResult.clear();
    searchText.value = "";
    searchTextController.clear();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
