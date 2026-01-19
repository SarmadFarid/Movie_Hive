 
import 'package:movie_hive/core/utills/app_imports.dart';
 

class TrendingMovieCard extends StatelessWidget {
  final MovieModel movie;

  const TrendingMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: (){
              Get.toNamed(AppRoutes.detail, arguments: movie, ); 
            },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.7),
              blurRadius: 8,
              offset: const Offset(0,3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: ImageHelper.getPosterUrl(movie.backdropPath),
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey.shade800),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
      
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                    stops: [0.6, 1.0],
                  ),
                ),
              ),
      
              Positioned(
                bottom: 15.h,
                right: 15.w,
                left: 15.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.rating, size: 16.sp),
                        SizedBox(width: 5.w),
                        Text(
                          "${movie.voteAverage.toStringAsFixed(1)} / 10",
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
