import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_constants.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {Key? key,
      required this.hintText,
      required this.items,
      required this.value,
      required this.errorText,
      required this.function})
      : super(key: key);
  final String hintText;
  final Iterable<String> items;
  final String? value;

  final String errorText;
  final Function function;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2(
        isExpanded: true,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(color: ColorConstants.instance.brickRed, width: 1.sp),
          ),
          errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 10.sp,
                color: ColorConstants.instance.brickRed,
              ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        hint: Row(
          children: [
            Expanded(
              child: Text(
                widget.hintText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return '    ${widget.errorText}';
          }
          return null;
        },
        value: widget.value,
        onChanged: (value) {
          setState(() {
            widget.function(value as String);
          });
        },
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 24.sp,
        ),
        iconEnabledColor: Colors.grey,
        iconDisabledColor: Colors.grey,
        buttonHeight: 46.h,
        buttonWidth: 240.w,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          border: Border.all(
            color: Colors.white,
          ),
          color: Colors.white,
        ),
        buttonElevation: 1,
        itemHeight: 46.h,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200.h,
        dropdownWidth: 240.w,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          color: Colors.white,
        ),
        dropdownElevation: 1,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(0, 0),
      ),
    );
  }
}
