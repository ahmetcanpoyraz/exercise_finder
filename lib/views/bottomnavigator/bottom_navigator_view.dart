import 'package:exercise_finder/core/constants/navigation_constant.dart';
import 'package:exercise_finder/views/filter/filter_view.dart';
import 'package:exercise_finder/views/myprogram/my_program_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_view/base_view.dart';
import '../home/home_view.dart';
import '../myprogram/my_program_view.dart';
import 'bottom_navigator_viewmodel.dart';

part 'bottom_navigator_widgets.dart';

class CustomButtomNavigation extends StatefulWidget {
  const CustomButtomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomButtomNavigation> createState() => _CustomButtomNavigationState();
}

class _CustomButtomNavigationState extends State<CustomButtomNavigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CustomBottomNavigationViewModel>(
      viewModel: Provider.of<CustomBottomNavigationViewModel>(context, listen: false),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, viewModel, child) => SafeArea(
        bottom: true,
        left: false,
        top: false,
        right: false,
        maintainBottomViewPadding: true,
        minimum: EdgeInsets.zero,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: Theme.of(context).colorScheme.background,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  body: Stack(
                    children: [
                      IndexedStack(
                        index: viewModel.controller,
                        children: [
                          Navigator(
                              key: viewModel.navigatorKey,
                              initialRoute: NavigationConstants.homePage,
                              onGenerateRoute: (settings) {
                                if (settings.name == NavigationConstants.homePage) {
                                  return MaterialPageRoute<String>(
                                    builder: (BuildContext context) => const HomeView(),
                                    settings: settings,
                                  );
                                } else if (settings.name == NavigationConstants.filterPage) {
                                  return MaterialPageRoute<String>(
                                    builder: (BuildContext context) => const FilterView(),
                                    settings: settings,
                                  );
                                }
                                return null;
                              }),
                          const MyProgramView(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: ButtomNavigationBarWidget(viewModel: viewModel),
        ),
      ),
    );
  }
}


