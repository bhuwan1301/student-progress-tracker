import 'package:get/get.dart';
import 'package:student_progress_tracker/screens/homepage.dart';
import 'package:student_progress_tracker/screens/login.dart';
import 'package:student_progress_tracker/screens/profile.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: '/profile',
      page: () => const ProfilePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
  ];
}
