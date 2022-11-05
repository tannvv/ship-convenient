import 'package:convenient_way/app/bindings/initial_binding.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        builder: ((context, child) => GetMaterialApp(
              title: 'Ship convenient',
              initialBinding: InitialBinding(),
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: const ColorScheme(
                  primary: AppColors.primary400,
                  secondary: AppColors.secondary400,
                  surface: AppColors.surface,
                  background: AppColors.background,
                  error: AppColors.error,
                  onPrimary: AppColors.onPrimary,
                  onSecondary: AppColors.onSecondary,
                  onSurface: AppColors.onSurface,
                  onBackground: AppColors.onBackground,
                  onError: AppColors.onError,
                  brightness: Brightness.light,
                ),
                focusColor: AppColors.orange,
              ),
            )));
  }
}
