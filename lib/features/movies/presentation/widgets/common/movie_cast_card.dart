import 'package:movie_hive/core/utills/app_imports.dart';

class MovieCastCard extends StatelessWidget {
  final CastModel cast;
  const MovieCastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: cast.profilePath.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: ImageHelper.getPosterUrl(cast.profilePath),
                      fit: BoxFit.cover,
                      height: 110.h,
                      width: double.infinity,
                    )
                  : Container(
                      height: 110.h,
                      width: double.infinity,
                      color: Colors.grey.shade900,
                      child: Icon(
                        Icons.person,
                        size: 50.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
            ),

            Positioned(
              top: 5.h,
              right: 5.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.whatshot, color: AppColors.rating, size: 10.sp),
                    TextWidget(
                      text: cast.popularity.toStringAsFixed(0),
                      fontSize: 8.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 6.h),

        TextWidget(
          textAlign: TextAlign.center,
          text: cast.name,
          fontSize: 11.sp,
        ),

        if (cast.originalName != cast.name)
          TextWidget(
            textAlign: TextAlign.center,
            text: "(${cast.originalName})",
            fontSize: 9.sp,
            color: AppColors.textSecondary,
          ),

        SizedBox(height: 2.h),

        TextWidget(
          textAlign: TextAlign.center,
          text: cast.charactor,
          fontSize: 10.sp,
          color: AppColors.primary,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
