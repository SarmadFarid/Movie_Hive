import 'package:movie_hive/core/utills/app_imports.dart';

class AppPages {
  static final List<GetPage> pages = [
     GetPage(name: AppRoutes.home, page: () => HomeView(), binding: HomeBinding()) , 
     GetPage(name: AppRoutes.detail, page: () => DetailView(), binding: DetailBinding()), 
     GetPage(name: AppRoutes.search, page: () => SearchView(), binding: SearchBinding())
  ];
}