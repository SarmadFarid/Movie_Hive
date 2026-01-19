import 'package:cine_flow/core/utills/app_imports.dart';
import 'package:cine_flow/features/movies/presentation/widgets/shimer/slider_shimmer.dart';
 

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "Welcome Back",
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                    TextWidget(
                      text: "Let's watch a movie!",
                      color: AppColors.textPrimary,
                      fontSize: 24.sp,
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.search);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 10.h,
                  ),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: Colors.grey.shade800,
                      width: 0.5.w,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: "Search your favourite movies...",
                        fontSize: 14.sp,
                        color: AppColors.textSecondary.withValues(alpha: 1.5),
                        fontWeight: FontWeight.w500,
                      ),

                      Icon(Icons.search, color: Colors.grey, size: 20),
                    ],
                  ),
                ),
              ),

              Obx(() {
                if (controller.isloading.value) {
                  return SliderShimmer();
                }
                if (controller.trendingMovies.isNotEmpty) {
                  return SizedBox(
                    height: 250.h,
                    width: double.infinity,
                    child: CarouselSlider.builder(
                      itemCount: controller.trendingMovies.length,
                      itemBuilder: (context, index, realIndex) {
                        final movie = controller.trendingMovies[index];
                        return TrendingMovieCard(movie: movie);
                      },
                      options: CarouselOptions(
                        height: 250.h,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        pageSnapping: false,
                        scrollPhysics: const BouncingScrollPhysics(),
                        viewportFraction: 0.53,
                        enlargeFactor: 0.28,
                        onPageChanged: (index, reason) {},
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
               
              
              // popular movies
              Obx(() {
                if (controller.isloadingPopularmovies.value) {
                  return GridcardShimmer(headerTitle: "Popular Movies");
                }
                if (controller.popularMovies.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(title: "Popular Movies"),
                      SizedBox(
                        height: 180.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          itemCount: controller.popularMovies.length,
                          itemExtent: 130.w,
                          itemBuilder: (context, index) {
                            final movie = controller.popularMovies[index];
                            return Container(
                              padding: EdgeInsets.only(bottom: 10.h),
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              child: MovieGridCard(movie: movie),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              }),
       
              // top rated movies
              Obx(() {
                if (controller.isloadingTopRated.value) {
                  return GridcardShimmer(headerTitle: "Top Rated");
                }
                if (controller.topRatedMovies.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(title: "Top Rated"),
                      SizedBox(
                        height: 180.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          itemCount: controller.topRatedMovies.length,
                          itemExtent: 130.w,
                          itemBuilder: (context, index) {
                            final movie = controller.topRatedMovies[index];
                            return Container(
                              padding: EdgeInsets.only(bottom: 10.h),
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              child: MovieGridCard(movie: movie),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              }),
 
              // now playing movies
              Obx(() {
                final data = controller.nowPlayingMoveis.value;

                if (controller.isloadingNowPlaying.value || data == null) {
                  return GridcardShimmer(headerTitle: "Currently Playing");
                }
                if (data.movies.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(title: "Currently Playing"),
                      SizedBox(
                        height: 180.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          itemCount: data.movies.length,
                          itemExtent: 130.w,
                          itemBuilder: (context, index) {
                            final movie = data.movies[index];
                            return Container(
                              padding: EdgeInsets.only(bottom: 10.h),
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              child: MovieGridCard(movie: movie),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              }),

              // upcomming movies
              Obx(() {
                final details = controller.upcommingMovies.value;
                if (controller.isloadingupComming.value || details == null) {
                  return GridcardShimmer(headerTitle: "Upcomming Movies");
                }
                if (details.movies.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(title: "Upcomming Movies"),
                      SizedBox(
                        height: 180.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          itemCount: details.movies.length,
                          itemExtent: 130.w,
                          itemBuilder: (context, index) {
                            final movie = details.movies[index];
                            return Container(
                              padding: EdgeInsets.only(bottom: 10.h),
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              child: MovieGridCard(movie: movie),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
