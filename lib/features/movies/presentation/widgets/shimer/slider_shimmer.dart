import 'package:cine_flow/core/utills/app_imports.dart';
 

class SliderShimmer extends StatelessWidget {
  const SliderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (context, index, realIndex) {
         return  ShimmerLoader(height: 250.h, width: double.infinity ,);
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
}
