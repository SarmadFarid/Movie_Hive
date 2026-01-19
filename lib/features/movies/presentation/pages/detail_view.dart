import 'package:cine_flow/core/utills/app_imports.dart';

class DetailView extends GetView<DetailsController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = controller.movie;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.scaffoldBackground,
            expandedHeight: 400.h,
            pinned: true,
            stretch: true,
            leading: Padding(
              padding: EdgeInsetsGeometry.all(8.w),
              child: CircleAvatar(
                backgroundColor: AppColors.scaffoldBackground.withValues(
                  alpha: 0.5,
                ),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsGeometry.all(8.w),
                child: CircleAvatar(
                  backgroundColor: AppColors.scaffoldBackground.withValues(
                    alpha: 0.5,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              title: TextWidget(
                text: movie.title,
                fontSize: 16.sp,
                // color: Colors.black,
                shadow: [Shadow(color: Colors.black, blurRadius: 10.r)],
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: ImageHelper.getPosterUrl(movie.backdropPath),
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ],
              ),
              titlePadding: EdgeInsetsDirectional.only(
                start: 50.w,
                bottom: 16.h,
                end: 40.w,
              ),
            ),
          ),
          
          // overview
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: TextWidget(
                text: movie.overview,
                maxLines: 4,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

        //  content details
          SliverToBoxAdapter(
            child: Obx(() {
              final details = controller.movieDetails.value;
              if (controller.isloadingDetails.value || details == null) {
                return DetailContentShimmer();
              }

              return Column(
                children: [
                  // tagline
                  if (details.tagline.isNotEmpty) ...[
                    Center(
                      child: TextWidget(
                        text: "“${details.tagline}”",
                        textAlign: TextAlign.center,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],

                  // runtime , release date ,status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconInfo(
                        Icons.access_time_filled,
                        "${details.runtime} min",
                      ),
                      _buildIconInfo(Icons.calendar_today, details.releaseDate),
                      _buildIconInfo(Icons.info_outline, details.status),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  //    Genres
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Center(
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: details.genres.map((genre) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(
                                alpha: 0.2,
                              ), // Halka Red
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: TextWidget(
                              text: genre.name,
                              fontSize: 12.sp,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),
                  // rating and popularity
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.rating.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.rating.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //   Vote Average
                        _buildRatingAndPopularity(
                          icon: Icons.star_rounded,
                          iconColor: AppColors.rating,
                          label: "Rating",
                          value:
                              "${details.voteAverage.toStringAsFixed(1)} / 10",
                        ),

                        // Vertical Divider
                        Container(
                          width: 1,
                          height: 30.h,
                          color: Colors.grey.withValues(alpha: 0.3),
                        ),

                        //  Vote Count
                        _buildRatingAndPopularity(
                          icon: Icons.people_alt_rounded,
                          iconColor: Colors.blueAccent,
                          label: "Votes",
                          value: NumberFormat.compact().format(
                            details.voteCount,
                          ),
                        ),

                        // Vertical Divider
                        Container(
                          width: 1,
                          height: 30.h,
                          color: Colors.grey.withValues(alpha: 0.3),
                        ),

                        //  Popularity
                        _buildRatingAndPopularity(
                          icon: Icons.trending_up_rounded,
                          iconColor: Colors.greenAccent,
                          label: "Hype",
                          value: details.popularity.toStringAsFixed(0),
                        ),
                      ],
                    ),
                  ),

                  //   language,  budget , revenue
                  Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem(
                          "Language",
                          details.originalLanguage.toUpperCase(),
                        ),
                        _buildStatItem(
                          "Budget",
                          "\$${(details.budget / 1000000).toStringAsFixed(1)}M",
                        ), // Millions ma convert
                        _buildStatItem(
                          "Revenue",
                          "\$${(details.revenue / 1000000).toStringAsFixed(1)}M",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            }),
          ),

          // actors
          SliverToBoxAdapter(
            child: Obx(() {
              if (controller.isloadingCast.value) {
                return GridcardShimmer(
                  headerTitle: "Actors",
                  height: 170.h,
                  width: 100.w,
                );
              }
              if (controller.castList.isNotEmpty) {
                return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(title: "Actors"),
                    SizedBox(
                      height: 180.h,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 10.h,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.castList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final cast = controller.castList[index];
                          return Container(
                            width: 100.w,
                            margin: EdgeInsets.only(right: 12.w),
                            child: MovieCastCard(cast: cast),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return SizedBox.shrink();
            }),
          ),

          // watch movie trailer button
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.7),
                  minimumSize: Size(double.infinity, 50.h),
                ),
                child: TextWidget(
                  text: "Watch Movie Trailer",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          //  production companies
          SliverToBoxAdapter(
            child: Obx(() {
              final details = controller.movieDetails.value;
              if (controller.isloadingDetails.value || details == null) {
                return GridcardShimmer(
                  headerTitle: "Produced By",
                  height: 50,
                  width: 80.w,
                );
              }
              if (details.productionCompanies.isNotEmpty) {
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(title: "Produced By"),
                    SizedBox(
                      height: 60.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: details.productionCompanies.length,
                        itemBuilder: (context, index) {
                          final company = details.productionCompanies[index];
                          return Container(
                            margin: EdgeInsets.only(right: 20.w),
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: company.logoPath.isNotEmpty
                                ? Image.network(
                                    ImageHelper.getPosterUrl(company.logoPath),
                                    fit: BoxFit.contain,
                                  )
                                : Center(
                                    child: TextWidget(
                                      text: company.name,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            }),
          ),

          // recommended movies
          SliverToBoxAdapter(
            child: Obx(() {
              if (controller.isloadingRecommended.value) {
                return GridcardShimmer(headerTitle: "Recommended For you");
              }
              if (controller.recommendedmovies.isNotEmpty) {
                return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(title: "Recommended For you"),
                    SizedBox(
                      height: 180.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.recommendedmovies.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        itemExtent: 130.w,
                        itemBuilder: (BuildContext context, int index) {
                          final movie = controller.recommendedmovies[index];
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            padding: EdgeInsets.only(bottom: 10.h),
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
          ),

          //  similar movies
          SliverToBoxAdapter(
            child: Obx(() {
              if (controller.isloadingSimilar.value) {
                return GridcardShimmer(headerTitle: "Similar Movies");
              }
              if (controller.similarMovies.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(title: "Similar Movies"),
                    SizedBox(
                      height: 180.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.similarMovies.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        itemExtent: 130.w,
                        itemBuilder: (BuildContext context, int index) {
                          final movie = controller.similarMovies[index];
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            padding: EdgeInsets.only(bottom: 10.h),
                             
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
          ),
        ],
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18.sp),
        SizedBox(width: 5.w),
        TextWidget(
          text: text,
          color: Colors.grey.shade300,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        TextWidget(
          text: label,
          color: AppColors.textSecondary,
          fontSize: 12.sp,
        ),
        SizedBox(height: 4.h),
        TextWidget(text: value, fontSize: 14.sp),
      ],
    );
  }

  Widget _buildRatingAndPopularity({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20.sp),
            SizedBox(width: 4.w),
            TextWidget(text: value, fontSize: 15.sp),
          ],
        ),
        SizedBox(height: 4.h),
        TextWidget(
          text: label,
          color: AppColors.textSecondary,
          fontSize: 11.sp,
        ),
      ],
    );
  }
}
