import 'package:movie_hive/core/utills/app_imports.dart';

class DetailContentShimmer extends StatelessWidget {
  const DetailContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // tagline
         SizedBox(height: 10.h),
        ShimmerLoader(height: 15.h, width: 200.w),
        SizedBox(height: 20.h),

        // runtime , release date ,status
        Padding(
          padding:   EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: ShimmerLoader(height: 15.h)),
              SizedBox(width: 8.w),
              Expanded(child: ShimmerLoader(height: 15.h)),
              SizedBox(width: 8.w),
              Expanded(child: ShimmerLoader(height: 15.h)),
            ],
          ),
        ),
        SizedBox(height: 20.h),

        //    Genres
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: List.generate(
                3,
                (index) =>
                    ShimmerLoader(height: 30.h, width: 90.w, radius: 30.r),
              ),
            ),
          ),
        ),

        SizedBox(height: 10.h),
        // rating and popularity
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
          decoration: BoxDecoration(
            // color: AppColors.rating.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.rating.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //   Vote Average
              Expanded(
                child: Column(
                  children: [
                    ShimmerLoader(height: 15.h, width: 50.w, radius: 4.r),
                    SizedBox(height: 6.h),
                    ShimmerLoader(height: 10.h, width: 40.w, radius: 4.r),
                  ],
                ),
              ),

              // Vertical Divider
              Container(
                width: 1,
                height: 30.h,
                color: Colors.grey.withValues(alpha: 0.3),
              ),

              //  Vote Count
              Expanded(
                child: Column(
                  children: [
                   ShimmerLoader(height: 15.h, width: 50.w, radius: 4.r),
                    SizedBox(height: 6.h),
                    ShimmerLoader(height: 10.h, width: 40.w, radius: 4.r),
                  ],
                ),
              ),

              // Vertical Divider
              Container(
                width: 1,
                height: 30.h,
                color: Colors.grey.withValues(alpha: 0.3),
              ),

              //  Popularity
              Expanded(
                child: Column(
                  children: [
                    ShimmerLoader(height: 15.h, width: 50.w, radius: 4.r),
                    SizedBox(height: 6.h),
                    ShimmerLoader(height: 10.h, width: 40.w, radius: 4.r),
                  ],
                ),
              ),
            ],
          ),
        ),

        //   language,  budget , revenue
        Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                     ShimmerLoader(height: 15.h, width: 50.w, radius: 4.r),
                    SizedBox(height: 6.h),
                    ShimmerLoader(height: 10.h, width: 40.w, radius: 4.r),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                     ShimmerLoader(height: 15.h, width: 50.w, radius: 4.r),
                    SizedBox(height: 6.h),
                    ShimmerLoader(height: 10.h, width: 40.w, radius: 4.r),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ShimmerLoader(height: 15.h, width: 50.w, radius: 4.r),
                    SizedBox(height: 6.h),
                    ShimmerLoader(height: 10.h, width: 40.w, radius: 4.r),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
    
  }
}
