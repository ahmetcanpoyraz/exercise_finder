import 'package:exercise_finder/views/filter/filter_view.dart';
import 'package:flutter/material.dart';
import '../../../views/bottomnavigator/bottom_navigator_view.dart';
import '../../../views/home/home_view.dart';
import '../../../views/myprogram/my_program_view.dart';
import '../../constants/navigation_constant.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      //  BOTTOMNAVIGATION
      case NavigationConstants.bottomNavigationBar:
        return normalNavigate(
            const CustomButtomNavigation(), NavigationConstants.bottomNavigationBar);
      // HOME
      case NavigationConstants.homePage:
        return normalNavigate(const HomeView(), NavigationConstants.homePage);
      // PROFİLE
      case NavigationConstants.myProgramPage:
        return normalNavigate(const MyProgramView(), NavigationConstants.myProgramPage);
    // FILTER
      case NavigationConstants.filterPage:
        return normalNavigate(const FilterView(), NavigationConstants.filterPage);
      //--DEFAULT--//
      default:
        return MaterialPageRoute(
          builder: (context) => const Text("Böyle Bir Sayfa Yok"),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName, {Object? data}) {
    return MaterialPageRoute(
        builder: (context) => widget, settings: RouteSettings(name: pageName, arguments: data));
  }

  PageRouteBuilder animetedNavigate(Widget widget, String pageName) {
    return PageRouteBuilder(
      settings: RouteSettings(name: pageName),
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation1, animation2) => widget,
      transitionsBuilder: (context, animation1, animation2, child) {
        return FadeTransition(opacity: animation1, child: child);
      },
    );
  }
}
