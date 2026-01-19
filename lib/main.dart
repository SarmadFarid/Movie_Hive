import 'package:flutter/services.dart';
import 'package:movie_hive/core/utills/app_imports.dart'; 
 

void main() {

 
  runZonedGuarded(
    () async {

        WidgetsFlutterBinding.ensureInitialized(); 
     
     await dotenv.load(fileName: ".env") ; 
      
      FlutterError.onError = (error)  {
        log("framework level error", error: error.toString()); 
      };

     await Hive.initFlutter(); 
     Hive.registerAdapter(MovieModelAdapter()); 
     await Hive.openBox<MovieModel>('movie_box'); 
     await Hive.openBox<MovieModel>("top_rated_movies");
     
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent)); 
     
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
      title: 'Movie Hive',
      getPages: AppPages.pages,
      initialRoute: AppRoutes.home,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    
    );
    },
    );
  }
}
  