import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/features/home/controller/hotel_controller.dart';

import 'src/core/authentication_manager.dart';
import 'src/core/services/dio_service.dart';
import 'src/features/splash/splash.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  Get.put(AuthenticationManager());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DioService().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());
  final HotelController hotelController = Get.put(HotelController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => KhaltiScope(
        publicKey: "test_public_key_546973b730cf43cf9f12946359b6b5fa",
        navigatorKey: navigatorKey,
        builder: (context, navigator) {
          return mainBody();
        },
      ),
    );
  }

  GetMaterialApp mainBody() {
    return GetMaterialApp(
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
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
