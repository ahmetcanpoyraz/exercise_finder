import 'package:exercise_finder/views/filter/filter_viewmodel.dart';
import 'package:exercise_finder/views/myprogram/my_program_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../views/bottomnavigator/bottom_navigator_viewmodel.dart';
import '../../../views/home/home_viewmodel.dart';

class ProviderManager {
  static ProviderManager? _instance;
  static ProviderManager get instance {
    _instance ??= ProviderManager._init();
    return _instance!;
  }

  ProviderManager._init();
  List<SingleChildWidget> singleProvider = [
    ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
    ),
    ChangeNotifierProvider<MyProgramViewModel>(
      create: (_) => MyProgramViewModel(),
    ),
    ChangeNotifierProvider<FilterViewModel>(
      create: (_) => FilterViewModel(),
    ),
    ChangeNotifierProvider<CustomBottomNavigationViewModel>(
      create: (_) => CustomBottomNavigationViewModel(),
    ),
  ];
}
