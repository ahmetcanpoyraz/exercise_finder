import 'package:exercise_finder/core/constants/color_constants.dart';
import 'package:exercise_finder/core/init/usecases/alert_dialog_helper.dart';
import 'package:exercise_finder/views/filter/filter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_view/base_view.dart';
import '../../core/global_widgets/custom_sliver_app_bar.dart';
import '../../core/global_widgets/custom_dropdown_button.dart';
import '../../core/global_widgets/custom_item_widget.dart';
import '../../core/constants/screen_constants/home_screen_contants.dart';
import '../../core/global_widgets/custom_text_field.dart';
import 'home_viewmodel.dart';

part 'home_widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        viewModel: Provider.of<HomeViewModel>(context, listen: false),
        onModelReady: (model) async {
          model.setContext(context);
          await model.init();
        },
        onPageBuilder: (context, viewModel, _) => GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                viewModel.chanceVisibleFilterList(false);
              },
              child: Scaffold(
                backgroundColor: ColorConstants.instance.kDarkGrey,
                body: CustomScrollView(
                  slivers: <Widget>[
                    const CustomSliverAppBar(title: "Home"),
                    SearchFilterWidget(viewModel: viewModel),
                    SliverToBoxAdapter(
                        child: Visibility(
                      visible: viewModel.showResultText,
                      child:
                          Center(child: Text("${viewModel.responseList!.length} results found.")),
                    )),
                    SuggestionListWidget(viewModel: viewModel),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => viewModel.loading
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 200.h,
                                  ),
                                  const Center(child: CircularProgressIndicator()),
                                ],
                              )
                            : CustomItemWidget(
                                list: viewModel.responseList,
                                index: index,
                                addButton: AddButton(viewModel: viewModel, index: index),
                              ),
                        childCount: viewModel.loading ? 1 : viewModel.responseList?.length,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
