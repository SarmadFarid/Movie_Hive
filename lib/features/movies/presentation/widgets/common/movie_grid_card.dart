import 'package:cine_flow/core/utills/app_imports.dart';

class MovieGridCard extends StatelessWidget {
  final MovieModel movie;
  const MovieGridCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.detail, arguments: movie);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: CachedNetworkImage(
              imageUrl: ImageHelper.getPosterUrl(movie.posterPath),
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),

        Positioned(
          top: 8.h,
          right: 8.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.rating.withValues(alpha: 0.5),
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: AppColors.rating, size: 10.sp),
                SizedBox(width: 2.w),
                TextWidget(
                  text: movie.voteAverage.toStringAsFixed(1),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
