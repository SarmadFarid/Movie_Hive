
import 'package:cine_flow/core/utills/app_imports.dart';

void main() {

  runZonedGuarded(
    () async {

     WidgetsBinding widgetsBinding =   WidgetsFlutterBinding.ensureInitialized(); 

     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      statusBarIconBrightness: Brightness.light, 
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.transparent, 
      systemNavigationBarIconBrightness: Brightness.light
      )
      ); 

     FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); 

     await dotenv.load(fileName: ".env") ;
     
      FlutterError.onError = (error)  {
        log("framework level error", error: error.toString()); 
      };

     await Hive.initFlutter(); 
     Hive.registerAdapter(MovieModelAdapter()); 
     await Hive.openBox<MovieModel>('movie_box'); 
     await Hive.openBox<MovieModel>("top_rated_movies");
     await Hive.openBox("api_cache"); 
     
     
     
     runApp(const MyApp()); 

    }, (error, stack) {
      log("critical error caught in zone: $error"); 
    }); 
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), 
      minTextAdapt: true, 
      splitScreenMode: true,
    builder:(context, child) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineFlow',
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true, 
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: AppColors.scaffoldBackground, 
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light, 
          backgroundColor: Colors.transparent, 
          elevation: 0,
        )
      ),
    
    );
    },
    );
  }
}
  