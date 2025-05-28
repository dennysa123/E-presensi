part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
  static const HOME = _Paths.HOME;
  static const ABSENSI = _Paths.ABSENSI;
  static const PRESENSI = _Paths.PRESENSI;
  static const PROFILE = _Paths.PROFILE;
  static const EDIT_PROFILE = _Paths.EDIT_PROFILE;
  static const INFORMASI = _Paths.INFORMASI; // Route untuk Informasi
  // Add other routes here
}

abstract class _Paths {
  _Paths._();
  
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const RESET_PASSWORD = '/reset-password';
  static const HOME = '/home';
  static const ABSENSI = '/absensi';
  static const PRESENSI = '/presensi';
  static const PROFILE = '/profile';
  static const EDIT_PROFILE = '/edit-profile';
  static const INFORMASI = '/informasi'; // Path untuk Informasi
  static const RIWAYAT = '/riwayat';
  // Add other paths here
}