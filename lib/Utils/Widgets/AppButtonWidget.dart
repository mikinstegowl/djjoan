import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class AppButtonWidget extends StatefulWidget {
  const AppButtonWidget({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.child,
    required this.onPressed,
    required this.btnName,
    this.txtColor,
    this.fontSize = 16,
    this.btnColor,
    this.margin,
    this.isEnable = true,
    this.fontWeight = FontWeight.w700,
    this.borderRadius = 0,
    this.borderColor,
    this.borderWidth = 1.0,
    this.shape = BoxShape.rectangle,
    this.whiteTextRollover = true,
    this.rolloverTextColor = AppColors.white,
  });

  /// Preconfigured Black button with Gold text and White text rollover
  const AppButtonWidget.black({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.child,
    required this.onPressed,
    required this.btnName,
    this.txtColor = AppColors.appButton,
    this.fontSize = 16,
    this.btnColor = AppColors.black,
    this.margin,
    this.isEnable = true,
    this.fontWeight = FontWeight.w700,
    this.borderRadius = 0,
    this.borderColor = AppColors.appButton,
    this.borderWidth = 1.0,
    this.shape = BoxShape.rectangle,
    this.whiteTextRollover = true,
    this.rolloverTextColor = AppColors.white,
  });

  /// Preconfigured Gold button with Black text and White text rollover
  const AppButtonWidget.gold({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.child,
    required this.onPressed,
    required this.btnName,
    this.txtColor = AppColors.black,
    this.fontSize = 16,
    this.btnColor = AppColors.appButton,
    this.margin,
    this.isEnable = true,
    this.fontWeight = FontWeight.w700,
    this.borderRadius = 0,
    this.borderColor = AppColors.transparent,
    this.borderWidth = 1.0,
    this.shape = BoxShape.rectangle,
    this.whiteTextRollover = true,
    this.rolloverTextColor = AppColors.white,
  });

  final double? height;
  final double? width;
  final double borderWidth;
  final Function() onPressed;
  final String btnName;
  final Color? txtColor;
  final double fontSize;
  final Color? btnColor;
  final FontWeight fontWeight;
  final double borderRadius;
  final Color? borderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool isEnable;
  final Widget? child;
  final BoxShape shape;
  final bool whiteTextRollover;
  final Color? rolloverTextColor;

  @override
  State<AppButtonWidget> createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget> {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get _isRollover =>
      (_isHovered || _isPressed) && widget.whiteTextRollover;

  Color get _effectiveTextColor {
    // 1. If actively rolled over (hovered or pressed), show white text rollover
    if (_isRollover) {
      return widget.rolloverTextColor ?? AppColors.white;
    }

    // 2. If caller provided an explicit text color, respect it
    if (widget.txtColor != null) {
      return widget.txtColor!;
    }

    final btn = widget.btnColor ?? AppColors.appButton;

    // 3. Gold Buttons -> Black Text
    if (btn == AppColors.appButton || btn == AppColors.gold) {
      return AppColors.black;
    }

    // 4. Black / Smoke Black / Dark Buttons -> Gold Text
    if (btn == AppColors.black ||
        btn == AppColors.smokeBlack ||
        btn == AppColors.smokeBlackDark ||
        btn == AppColors.smokeBlackLight ||
        btn == AppColors.textFormFieldTextColor ||
        btn == AppColors.textFormFieldColor ||
        btn.computeLuminance() < 0.25) {
      return AppColors.appButton;
    }

    // 5. Default contrast: light button -> black text, dark button -> gold text
    return btn.computeLuminance() > 0.5 ? AppColors.black : AppColors.appButton;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = widget.borderColor ??
        (widget.btnColor == AppColors.black
            ? const Color(0x99D4AF37) // Subtle gold border for black buttons
            : AppColors.transparent);

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: widget.isEnable ? widget.onPressed : () {},
        onHover: widget.isEnable
            ? (hovering) {
                if (_isHovered != hovering) {
                  setState(() => _isHovered = hovering);
                }
              }
            : null,
        onHighlightChanged: widget.isEnable
            ? (highlighted) {
                if (_isPressed != highlighted) {
                  setState(() => _isPressed = highlighted);
                }
              }
            : null,
        splashColor: const Color(0x1FFFFFFF),
        highlightColor: const Color(0x14FFFFFF),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          height: widget.height?.h,
          width: widget.width?.w,
          padding: widget.padding ?? EdgeInsets.symmetric(vertical: 10.r),
          margin: widget.margin,
          decoration: BoxDecoration(
            shape: widget.shape,
            color: widget.btnColor,
            border: Border.all(
              color: effectiveBorderColor,
              width: widget.borderWidth,
            ),
            borderRadius: widget.shape == BoxShape.circle
                ? null
                : BorderRadius.circular(widget.borderRadius.r),
          ),
          child: widget.child ??
              AppTextWidget(
                maxLine: 3,
                textAlign: TextAlign.center,
                txtTitle: widget.btnName,
                fontSize: widget.fontSize,
                txtColor: _effectiveTextColor,
                fontWeight: widget.fontWeight,
              ),
        ),
      ),
    );
  }
}
