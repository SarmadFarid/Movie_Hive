import 'package:cine_flow/core/utills/app_imports.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool isLoading;

  const SectionHeader({
    super.key,
    required this.title,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}