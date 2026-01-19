import 'package:movie_hive/core/utills/app_imports.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final int? maxLines;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign; 
  final FontStyle?  fontStyle;  
  final List<Shadow>? shadow; 
  const TextWidget({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.textAlign, 
    this.fontStyle, 
    this.shadow
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis, 
      style: GoogleFonts.poppins(
        fontSize: fontSize ?? 18.sp,
        fontStyle: fontStyle,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? AppColors.textPrimary,
        shadows: shadow
      ),
    );
  }
}
