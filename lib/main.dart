import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:orb/src/core/constants/colors.dart';

import 'src/features/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: 'ORB',
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale('en')],
        localizationsDelegates: const [
          CountryLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: whiteColor,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: primaryColor,
              )),
          primarySwatch: MaterialColor(0xff0A85B4, const {
            50: Color(0xff0A85B4),
            100: Color(0xff0A85B4),
            200: Color(0xff0A85B4),
            300: Color(0xff0A85B4),
            400: Color(0xff0A85B4),
            500: Color(0xff0A85B4),
            600: Color(0xff0A85B4),
            700: Color(0xff0A85B4),
            800: Color(0xff0A85B4),
            900: Color(0xff0A85B4),
          }),
        ),
        home: SplashPage(),
      ),
    );
  }
}
