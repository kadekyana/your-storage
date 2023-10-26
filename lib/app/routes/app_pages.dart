import 'package:get/get.dart';

import '../modules/AfterSplash/bindings/after_splash_binding.dart';
import '../modules/AfterSplash/views/after_splash_view.dart';
import '../modules/BottomBar/bindings/bottom_bar_binding.dart';
import '../modules/BottomBar/views/bottom_bar_view.dart';
import '../modules/DetailBarang/bindings/detail_barang_binding.dart';
import '../modules/DetailBarang/views/detail_barang_view.dart';
import '../modules/EditBarang/bindings/edit_barang_binding.dart';
import '../modules/EditBarang/views/edit_barang_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Profile/bindings/profile_binding.dart';
import '../modules/Profile/views/profile_view.dart';
import '../modules/QRCode/bindings/q_r_code_binding.dart';
import '../modules/QRCode/views/q_r_code_view.dart';
import '../modules/Registrasi/bindings/registrasi_binding.dart';
import '../modules/Registrasi/views/registrasi_view.dart';
import '../modules/Scanner/bindings/scanner_binding.dart';
import '../modules/Scanner/views/scanner_view.dart';
import '../modules/TambahBarang/bindings/tambah_barang_binding.dart';
import '../modules/TambahBarang/views/tambah_barang_view.dart';
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
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.Q_R_CODE,
      page: () => const QRCodeView(),
      binding: QRCodeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_BARANG,
      page: () => DetailBarangView(
        qrResult: '',
      ),
      binding: DetailBarangBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_BARANG,
      page: () => TambahBarangView(),
      binding: TambahBarangBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_BARANG,
      page: () => EditBarangView(),
      binding: EditBarangBinding(),
    ),
    GetPage(
      name: _Paths.SCANNER,
      page: () => const ScannerView(),
      binding: ScannerBinding(),
    ),
  ];
}
