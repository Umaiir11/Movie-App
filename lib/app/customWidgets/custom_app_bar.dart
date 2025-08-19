import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_assignment/app/config/sizedbox_extension.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? toolBarHeight;
  final Color? backButtonColor;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final double elevation;
  final double? titleTextFont;
  final Color backgroundColor;
  final Color shadowColor;
  final Color titleColor;
  final Widget? trailing;
  final Widget? leading;
  final bool shouldAddBG;
  final Widget? titleWidget;
  final double? leadingWidth;
  final double? borderRadius;
  final bool? isBlack;

  final SystemUiOverlayStyle? statusBarStyle;

  const CustomAppBar({
    Key? key,
    this.title,
    this.leadingWidth,
    this.onBackPressed,
    this.centerTitle = true,
    this.elevation = 0.0,
    this.backgroundColor = AppColors.scaffoldBgColor,
    this.shadowColor = Colors.black,
    this.titleColor = Colors.white,
    this.trailing,
    this.leading,
    this.shouldAddBG = false,
    this.statusBarStyle,
    this.titleWidget,
    this.backButtonColor,
    this.toolBarHeight,
    this.borderRadius,
    this.titleTextFont,
    this.isBlack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(borderRadius ?? 25.sp), // Adjust radius as needed
        ),
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 10,
      toolbarHeight: toolBarHeight ?? kToolbarHeight,
      scrolledUnderElevation: 0.0,
      systemOverlayStyle:
          statusBarStyle ??
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.dark),
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      leadingWidth: leadingWidth ?? 70.w,
      elevation: elevation,
      shadowColor: shadowColor.withOpacity(0.3),
      centerTitle: centerTitle,
      leading: leading,
      // flexibleSpace: shouldAddBG,
      title: title != null
          ? Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: AppTextStyles.customText(fontSize: titleTextFont ?? 20, color: titleColor, fontWeight: FontWeight.w600),
            )
          : titleWidget,
      actions: [if (trailing != null) trailing!, 10.w.width],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight ?? kToolbarHeight);
}
