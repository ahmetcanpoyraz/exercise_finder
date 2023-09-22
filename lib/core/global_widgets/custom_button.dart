// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  bool? isActive;
  bool? isLoading;
  String? text;
  double width;
  double height;
  Function()? onPressed;
  TextStyle? textStyle;
  Widget? widget;
  Color? color;
  Color? borderColor;
  CustomButton({
    Key? key,
    this.isActive,
    this.onPressed,
    this.text,
    this.widget,
    required this.height,
    this.textStyle,
    this.isLoading,
    this.color,
    this.borderColor,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isLoading ?? false || isActive == false) ? () {} : onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        fixedSize: MaterialStateProperty.all<Size>(Size(width, height)),
        elevation: MaterialStateProperty.all<double>(0.0),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: isActive != null
            ? isActive!
                ? color != null
                    ? MaterialStateProperty.all<Color>(color!)
                    : MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary)
                : MaterialStateProperty.all<Color>(ColorConstants.instance.geyser)
            : color != null
                ? MaterialStateProperty.all<Color>(color!)
                : MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.sp),
            side: BorderSide(
              color: isActive != null
                  ? isActive!
                      ? borderColor ?? color ?? Theme.of(context).colorScheme.primary
                      : ColorConstants.instance.geyser
                  : borderColor ?? color ?? Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      child: isLoading ?? false
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          : widget ??
              Text(
                text ?? "",
                style: textStyle ??
                    Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 16.sp,
                        ),
              ),
    );
  }
}
