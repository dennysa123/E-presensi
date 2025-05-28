import 'package:get/get.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/register_view.dart';
import '../modules/login/views/reset_password_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/register_binding.dart';
import '../modules/login/bindings/reset_password_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../widgets/splash.dart';

// Import for Absensi module
import '../modules/login/bindings/absensi_binding.dart';
import '../modules/login/views/absensi_view.dart';

// Import for Presensi module
import '../modules/login/bindings/presensi_binding.dart';
import '../modules/login/views/presensi_view.dart';

// Import for Profile module
import '../modules/login/bindings/profile_binding.dart';
import '../modules/login/views/profile_view.dart';

// Import for Edit Profile module
import '../modules/login/bindings/edit_profile_binding.dart';
import '../modules/login/views/edit_profile_view.dart';

// Import for Informasi module
import '../modules/login/bindings/informasi_binding.dart';
import '../modules/login/views/informasi_view.dart';

import '../modules/login/bindings/riwayat_binding.dart';
import '../modules/login/views/riwayat_view.dart';



part 'app_routes.dart';

class AppPages {
  AppPages._();
  
  static const INITIAL = Routes.SPLASH;
  
  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    // Route for Absensi page (Ringkasan Siswa)
    GetPage(
      name: _Paths.ABSENSI,
      page: () => const AbsensiView(),
      binding: AbsensiBinding(),
    ),
    // Route for Presensi page (Calendar view)
    GetPage(
      name: _Paths.PRESENSI,
      page: () => const PresensiView(),
      binding: PresensiBinding(),
    ),
    // Route for Profile page
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    // Route for Edit Profile page
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    // Route for Informasi page
    GetPage(
      name: _Paths.INFORMASI,
      page: () => const InformasiView(),
      binding: InformasiBinding(),
    ),
    GetPage(
  name: _Paths.RIWAYAT,
  page: () => const RiwayatView(),
  binding: RiwayatBinding(),
),
  ];
}