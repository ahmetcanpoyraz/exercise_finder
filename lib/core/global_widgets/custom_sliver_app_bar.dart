import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_constants.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: false,
      pinned: false,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(title,
            style: TextStyle(
                color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold) //TextStyle
            ),
      ),
      expandedHeight: 70.h,
      backgroundColor: ColorConstants.instance.kDarkGrey,
    );
  }
}
