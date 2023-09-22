// ignore_for_file: unnecessary_null_comparison
import 'package:exercise_finder/views/filter/filter_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_view/base_view.dart';
import '../../core/global_widgets/custom_button.dart';
import '../../core/global_widgets/custom_sliver_app_bar.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/screen_constants/home_screen_contants.dart';

part 'filter_widgets.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<FilterViewModel>(
        viewModel: Provider.of<FilterViewModel>(context, listen: false),
        onModelReady: (model) async {
          model.setContext(context);
          await model.init();
        },
        onPageBuilder: (context, viewModel, _) => Scaffold(
              backgroundColor: ColorConstants.instance.kDarkGrey,
              body: CustomScrollView(
                slivers: <Widget>[
                  const CustomSliverAppBar(title: "Filter"),
                  SliverToBoxAdapter(
                    child: Container(
                      color: ColorConstants.instance.kDarkGrey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomButton(
                            height: 50.h,
                            width: 300.w,
                            text: "Clear All Filters",
                            onPressed: () {
                              viewModel.onClearAllFilters();
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Muscles",
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          FilterOptionsWidget(
                            viewModel: viewModel,
                            isMuscles: true,
                            list: HomeScreenConstants.instance.muscleList,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Types",
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          FilterOptionsWidget(
                            viewModel: viewModel,
                            isMuscles: false,
                            list: HomeScreenConstants.instance.typeList,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomButton(
                            height: 50.h,
                            width: 300.w,
                            text: "Okey",
                            onPressed: () {
                              viewModel.onOkey();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
