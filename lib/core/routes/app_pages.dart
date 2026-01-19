import 'package:cine_flow/core/utills/app_imports.dart';
import 'package:cine_flow/features/movies/presentation/bindings/splash_binding.dart';
import 'package:cine_flow/features/movies/presentation/pages/splash_view.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => SplashView(), binding: SplashBinding()), 
     GetPage(name: AppRoutes.home, page: () => HomeView(), binding: HomeBinding(), transition: Transition.fadeIn) , 
     GetPage(name: AppRoutes.detail, page: () => DetailView(), binding: DetailBinding(), transition: Transition.fadeIn), 
     GetPage(name: AppRoutes.search, page: () => SearchView(), binding: SearchBinding(), transition: Transition.fadeIn)
  ];
}