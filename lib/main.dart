import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_hive/core/routes/app_routes.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
             
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
           _incrementCounter(); 
        //  controller.fetchTrendingMovies(); 
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


/* 
lib/
├── core/                         # Jo puri app mein common rahega
│   ├── theme/
│   │   └── appColors.dart
│   ├── routes/
│   │   └── appRoutes.dart
│   │   └── appPages.dart
│   ├── errors/
│   │   └── failure.dart          # Error handling class
│   ├── network/
│   │   ├── api_constants.dart    # URL aur Keys yahan rahengi
│   │   ├── dio_client.dart       # Dio Setup (Interceptor wala)
│   │   └── api_interceptors.dart # Token inject karne k liye
│   ├── services/
│   │   └── storage_service.dart  # Hive Setup
│   └── utils/
│       └── ui_helpers.dart       # Snackbar helpers
│
├── features/                     # App k main features
│   └── movies/
│       ├── data/                 # Data Layer (Dirty Work)
│       │   ├── datasources/      # API calls (Remote) & Hive calls (Local)
│       │   ├── models/           # JSON/Hive Models (e.g. MovieModel)
│       │   └── repositories/     # Repo Implementation (Either logic yahan hogi)
│       │
│       ├── domain/               # Domain Layer (Pure Logic - No Flutter code)
│       │   ├── entities/         # Simple Dart Class (e.g. Movie)
│       │   └── repositories/     # Abstract Class (Contract/Interface)
│       │
│       └── presentation/         # UI Layer (Visible Work)
│           ├── controllers/      # GetX Controllers
│           ├── pages/            # Screens (Home, Detail, Search)
│           └── widgets/          # Small parts (MovieCard, RatingBadge)
│
└── main.dart                     # Entry Point


 
*/