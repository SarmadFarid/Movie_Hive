import 'package:movie_hive/core/utills/app_imports.dart';

class GridcardShimmer extends StatelessWidget {
  final String headerTitle;

  final double? height;
  final double? width;
  const GridcardShimmer({
    super.key,
    required this.headerTitle,

    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: headerTitle),
          SizedBox(
            height: height ?? 180.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemCount: 5,
              itemExtent: width ?? 130.w,
              itemBuilder: (context, index) {
                return Padding(
                  padding:   EdgeInsets.symmetric(horizontal: 5.w),
                  child: ShimmerLoader(height: 180.h, width: double.infinity),
                );
              },
            ),
          ),
        ],
      );
   
  }
}
