import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  final bool? obscureText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isDisabled;
  final TextAlign? textAlign;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool readOnly;
  final String? errorText;
  final ValueChanged? onChanged;
  final FormFieldValidator? validator;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? inputType;
  final TextCapitalization? capitalization;
  final Function()? onEditingComplete;
  final bool? autoCorrect;
  final Widget? icon;
  final int? maxLength;
  final bool autoFocus;
  final double borderRadius;
  final double? height;
  final double? width;
  final int? maxLines;
  final int? minLines;
  final bool? isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final TextInputAction? action;
  final Function(String)? onAction;
  final bool enableSuggestions;
  final bool inlinePadding;
  final TextStyle? textStyle;

  const CustomTextField({
    Key? key,
    this.obscureText,
    this.hintText,
    this.hintTextStyle,
    this.suffixIcon,
    this.textAlign,
    this.onTap,
    this.height,
    this.width,
    this.prefixIcon,
    this.icon,
    this.isDisabled,
    this.readOnly = false,
    this.controller,
    this.errorText,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.inputType,
    this.capitalization,
    this.maxLength,
    this.autoCorrect,
    this.borderRadius = 10,
    this.autoFocus = false,
    this.inputFormatters,
    this.maxLines,
    this.minLines,
    this.isRequired = false,
    this.borderColor,
    this.action,
    this.onAction,
    this.inlinePadding = false,
    this.enableSuggestions = true,
    this.textStyle,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle ??
          Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 16.sp,
                color: ColorConstants.instance.mineShaft,
              ),
      onTap: onTap,
      controller: controller,
      onChanged: onChanged,
      textAlign: textAlign ?? TextAlign.left,
      readOnly: readOnly,
      obscureText: obscureText ?? false,
      validator: validator,
      keyboardType: inputType,
      textCapitalization: capitalization ?? TextCapitalization.none,
      autocorrect: autoCorrect ?? false,
      onEditingComplete: onEditingComplete,
      autovalidateMode: autovalidateMode,
      maxLength: maxLength,
      minLines: minLines,
      autofocus: autoFocus,
      enableSuggestions: enableSuggestions,
      maxLines: maxLines ?? 1,
      textInputAction: TextInputAction.go,
      onFieldSubmitted: onAction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        errorMaxLines: 2,
        constraints: BoxConstraints(maxHeight: 90.h, minHeight: 50.h),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.instance.brickRed,
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        contentPadding: inlinePadding
            ? EdgeInsets.only(top: 10.h, left: 10.h, right: 0.h, bottom: 0)
            : EdgeInsets.only(top: 10.h, left: 10.h, bottom: 0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25.r),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: Colors.white,
        filled: true,
        hintText: isRequired! ? '$hintText *' : hintText,
        hintStyle: hintTextStyle ??
            Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 16.sp,
                  color: ColorConstants.instance.mineShaft.withOpacity(0.5),
                ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        errorText: errorText,
        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 10.sp,
              color: ColorConstants.instance.brickRed,
            ),
      ),
    );
  }
}
