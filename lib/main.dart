import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/provider/provider_manager.dart';
import 'core/init/provider/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...ProviderManager.instance.singleProvider],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(390, 844),
        builder: (context, child) => ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
            builder: (context, _) {
              final themeProvider = Provider.of<ThemeProvider>(context);
              return MaterialApp(
                themeMode: themeProvider.themeMode,
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.lightTheme,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: NavigationRoute.instance.generateRoute,
                navigatorKey: NavigationService.instance.navigatorKey,
              );
            }),
      ),
    );
  }
}
