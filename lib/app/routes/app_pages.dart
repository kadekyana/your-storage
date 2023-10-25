import 'package:get/get.dart';

import '../modules/AfterSplash/bindings/after_splash_binding.dart';
import '../modules/AfterSplash/views/after_splash_view.dart';
import '../modules/BottomBar/bindings/bottom_bar_binding.dart';
import '../modules/BottomBar/views/bottom_bar_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Profile/bindings/profile_binding.dart';
import '../modules/Profile/views/profile_view.dart';
import '../modules/Registrasi/bindings/registrasi_binding.dart';
import '../modules/Registrasi/views/registrasi_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.AFTER_SPLASH,
      page: () => const AfterSplashView(),
      binding: AfterSplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRASI,
      page: () => RegistrasiView(),
      binding: RegistrasiBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_BAR,
      page: () => BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
