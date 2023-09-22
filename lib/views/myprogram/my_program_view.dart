// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_view/base_view.dart';
import '../../core/global_widgets/custom_item_widget.dart';
import '../../core/global_widgets/custom_sliver_app_bar.dart';
import '../../core/constants/color_constants.dart';
import 'my_program_viewmodel.dart';

part 'my_program_widgets.dart';

class MyProgramView extends StatefulWidget {
  const MyProgramView({Key? key}) : super(key: key);

  @override
  State<MyProgramView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<MyProgramView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyProgramViewModel>(
        viewModel: Provider.of<MyProgramViewModel>(context, listen: false),
        onModelReady: (model) async {
          model.setContext(context);
          await model.init();
        },
        onPageBuilder: (context, viewModel, _) => Scaffold(
              backgroundColor: ColorConstants.instance.kDarkGrey,
              body: CustomScrollView(
                slivers: <Widget>[
                  const CustomSliverAppBar(title: "My Program"),
                  SliverToBoxAdapter(
                    child: DefaultTabController(
                        length: viewModel.itemsByGroups?.length ?? 0, // length of tabs
                        initialIndex: 0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TabBar(
                                isScrollable: true,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                dividerColor: Colors.transparent,
                                indicatorColor: Colors.transparent,
                                onTap: (index) {
                                  viewModel.changeCurrentIndex(index);
                                },
                                tabs: List.generate(
                                    viewModel.itemsByGroups?.length ?? 0,
                                    (index) => TabsWidget(
                                          index: index,
                                          viewModel: viewModel,
                                        )),
                              ),
                              SizedBox(
                                  height: 600.h,
                                  child: TabBarView(
                                    physics: const NeverScrollableScrollPhysics(),
                                    children: List.generate(
                                      viewModel.itemsByGroups?.length ?? 0,
                                      (tabIndex) => ListView.builder(
                                          itemCount: viewModel.itemsByGroups?[tabIndex].length ?? 0,
                                          itemBuilder: (BuildContext context, int index) {
                                            return DissmissibleWidget(
                                              viewModel: viewModel,
                                              index: index,
                                              tabIndex: tabIndex,
                                            );
                                          }),
                                    ),
                                  ))
                            ])),
                  ),
                ],
              ),
            ));
  }
}
