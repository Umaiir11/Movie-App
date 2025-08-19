import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_assignment/app/config/sizedbox_extension.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class AppCustomButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final double? borderRadius;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isGradientEnabled;
  final Color? bgColor;
  final Color? borderColor;
  final GlobalKey? textKey;

  const AppCustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.gradient,
    this.borderRadius,
    this.height,
    this.width,
    this.textStyle,
    this.icon,
    this.isGradientEnabled = false,
    this.bgColor,
    this.borderColor,
    this.textKey,
  });

  @override
  State<AppCustomButton> createState() => _AppCustomButtonState();
}

class _AppCustomButtonState extends State<AppCustomButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
    HapticFeedback.lightImpact();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          height: widget.height ?? 55.h,
          width: widget.width ?? double.infinity,
          decoration: BoxDecoration(
            color: widget.bgColor ?? AppColors.primary,
            gradient: !widget.isGradientEnabled
                ? null
                : widget.gradient ?? const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primary, AppColors.white]),
            border: Border.all(color: widget.borderColor ?? AppColors.transparent),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 14.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.icon != null) widget.icon!,
              if (widget.icon != null) 6.width,
              Text(
                widget.title,
                key: widget.textKey,
                style: widget.textStyle ?? AppTextStyles.customText16(color: AppColors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
