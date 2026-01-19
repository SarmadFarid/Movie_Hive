import 'package:cine_flow/core/utills/app_imports.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final double? height; 
  final double? width; 
  final double radius; 
  const ShimmerLoader({super.key, 
    this.height, this.width , this.radius  =10
   });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade800,
      child: Container(
        height: height, 
        width:width , 
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
         borderRadius: BorderRadius.circular(radius), 
        ),
      ),
    );
  }
}
