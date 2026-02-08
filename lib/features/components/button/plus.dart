import 'package:sukientotapp/core/utils/import/global.dart';

class CustomButtonPlus extends StatelessWidget {
  final VoidCallback onTap;
  final String btnText;
  final double? width;
  final double? height;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;
  final bool isDisabled;
  final bool isLoading;
  final Color color;
  final Color borderColor;
  final Color shadowColor;
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final IconData? icon;
  final double iconSize;
  final ImageProvider<Object>? image;
  final String? svgImage;
  final Color? iconColor;
  final Color? imageColor;

  const CustomButtonPlus({
    super.key,
    required this.onTap,
    required this.btnText,
    this.width,
    this.height,
    this.leftPadding = 0,
    this.topPadding = 0,
    this.rightPadding = 0,
    this.bottomPadding = 0,
    this.isDisabled = false,
    this.isLoading = false,
    this.color = AppColors.red600,
    this.borderColor = AppColors.lightMutedForeground,
    this.shadowColor = Colors.transparent,
    this.textColor = AppColors.white,
    this.textSize = 16,
    this.fontWeight = FontWeight.normal,
    this.borderRadius = 50,
    this.icon,
    this.iconSize = 20,
    this.image,
    this.svgImage,
    this.iconColor,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(leftPadding, topPadding, rightPadding, bottomPadding),
      child: ElevatedButton(
        onPressed: (isDisabled || isLoading) ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? AppColors.lightMutedForeground : color,
          foregroundColor: textColor,
          minimumSize: Size(width ?? 20, height ?? 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor, width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shadowColor: shadowColor,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: iconColor ?? AppColors.white, size: iconSize),
                    const SizedBox(width: 8),
                  ],
                  if (image != null) ...[
                    Image(image: image!, height: 24, width: 24, color: imageColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    btnText,
                    style: TextStyle(color: textColor, fontSize: textSize, fontWeight: fontWeight),
                  ),
                ],
              ),
      ),
    );
  }
}
