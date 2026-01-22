import 'package:cine_flow/core/utills/app_imports.dart';
import 'package:dio/dio.dart';

class SearchMovieController extends GetxController {
  final MovieRepository _repo;
  SearchMovieController(this._repo);

  final searchTextController = TextEditingController();
  var searchResult = <MovieModel>[].obs;
  var searchText = "".obs;
  var errorMessage = "".obs;
  var iserror = false.obs;
  var isloadingSearch = false.obs;
  CancelToken? _searchCancelToken; 

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
    if(_searchCancelToken != null && !_searchCancelToken!.isCancelled) {
      _searchCancelToken!.cancel("Cancel due to new query");
    } 
     _searchCancelToken = CancelToken(); 

    isloadingSearch.value = true;
    final result = await _repo.searchMovies(query, cancelToken: _searchCancelToken);
    result.fold(
      (failure) {
        isloadingSearch.value = false;
        iserror.value = true;
        if(failure.message == "Request Cancelled" || failure.message.contains("Cancelled")) {
          log("Search Cancelled logic works : previous query ignored"); 
        }
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
    if(_searchCancelToken != null && !_searchCancelToken!.isCancelled){
      _searchCancelToken!.cancel("Page closed!");
    }
    super.onClose();
  }
}
