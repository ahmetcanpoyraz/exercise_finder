import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/color_constants.dart';
import '../models/response_model.dart';

class CustomItemWidget extends StatelessWidget {
  const CustomItemWidget({
    super.key,
    required this.list,
    required this.index,
    this.addButton,
  });

  final List<ResponseModel>? list;
  final int index;
  final Widget? addButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
      child: Container(
        margin: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      list?[index].name ?? "",
                    ),
                  ),
                  addButton ?? const SizedBox(),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: ColorConstants.instance.kDarkGrey,
                      borderRadius: BorderRadius.all(Radius.circular(25.r))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
                    child: Text(list?[index].type ?? ""),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Text(list?[index].muscle ?? ""),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
