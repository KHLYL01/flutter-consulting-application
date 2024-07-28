import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/core/constant/routes_name.dart';
import 'package:my_project/core/middleware/middleware.dart';
import 'package:my_project/view/screen/auth/expert_page.dart';
import 'package:my_project/view/screen/auth/login.dart';
import 'package:my_project/view/screen/auth/register.dart';
import 'package:my_project/view/screen/entry_page.dart';
import 'package:my_project/view/screen/splash_screen.dart';
import 'package:my_project/view/screen/splash_screen/category_page.dart';
import 'package:my_project/view/screen/splash_screen/favourite_page.dart';
import 'package:my_project/view/screen/splash_screen/profile_page.dart';
import 'package:my_project/view/screen/splash_screen/time/Appointment_Booking_time_page.dart';
import 'package:my_project/view/screen/splash_screen/time/availablet_time.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/', page: () => EntryPage(), middlewares: [MyMiddleware()]),
  // GetPage(name: '/', page: () => ExpertPage()),
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.register, page: () => const Register()),
  GetPage(name: AppRoute.expertPage, page: () => ExpertPage()),
  GetPage(name: AppRoute.splashPage, page: () => const SplashPage()),
  GetPage(name: AppRoute.favouritePage, page: () => FavouritePage()),
  GetPage(name: AppRoute.categoryPage, page: () => CategoryPage()),
  GetPage(name: AppRoute.profilePage, page: () => const ProfilePage()),
  GetPage(
      name: AppRoute.appointmentBookingPage,
      page: () => const AppointmentBookingPage()),
  GetPage(name: AppRoute.availableTime, page: () => const AvailableTimePage()),
];

// Map<String, Widget Function(BuildContext)> routes = {
//   AppRoute.login: (context) => Login(),
//   AppRoute.register: (context) => Register(),
// };
