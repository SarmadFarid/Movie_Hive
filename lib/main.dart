import 'package:flutter/services.dart';
import 'package:cine_flow/core/utills/app_imports.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'; 
 

void main() {

 
  runZonedGuarded(
    () async {

     WidgetsBinding widgetsBinding =   WidgetsFlutterBinding.ensureInitialized(); 
     FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); 
     await dotenv.load(fileName: ".env") ;
     
      FlutterError.onError = (error)  {
        log("framework level error", error: error.toString()); 
      };

     await Hive.initFlutter(); 
     Hive.registerAdapter(MovieModelAdapter()); 
     await Hive.openBox<MovieModel>('movie_box'); 
     await Hive.openBox<MovieModel>("top_rated_movies");
     
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      statusBarIconBrightness: Brightness.light, 
      statusBarBrightness: Brightness.dark,
      )
      ); 
     
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    
    );
    },
    );
  }
}
  