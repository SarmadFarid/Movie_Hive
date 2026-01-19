import 'package:cine_flow/core/utills/app_imports.dart';
import 'package:cine_flow/features/movies/presentation/controllers/splash_contrller.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashView extends GetView<SplashContrller> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final text = "CineFlow";
    final letters = text.split("");
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: letters.asMap().entries.map((entry) {
            final index = entry.key;
            final letter = entry.value;

            return Text(
                  letter,
                  style: GoogleFonts.poppins(
                    fontSize: 42.sp,
                    fontWeight: FontWeight.bold,
                    color: index >= 4
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                )
                .animate(
                  delay: (index * 180).ms,
                  onComplete: (controller) {
                    if (index == letters.length - 1) {
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        Get.offNamed(AppRoutes.home);
                      });
                    }
                  },
                )
                .fadeIn(duration: 600.ms)
                .blurX(begin: 10, end: 0, duration: 500.ms)
                .slideX(
                  begin: 2.0,
                  end: 0.0,
                  duration: 800.ms,
                  curve: Curves.easeOutCubic,
                );
          }).toList(),
        ),
      ),
    );
  }
}
