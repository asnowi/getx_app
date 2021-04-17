
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/findPwd/findPwd_binding.dart';
import 'package:getx_app/pages/findPwd/findPwd_view.dart';
import 'package:getx_app/pages/home/home_binding.dart';
import 'package:getx_app/pages/home/home_view.dart';
import 'package:getx_app/pages/login/login_binding.dart';
import 'package:getx_app/pages/login/login_view.dart';

part 'app_routes.dart';
class AppPages {
  static const INITIAL = AppRoutes.home;

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.findPwd,
      page: () => FindPwdView(),
      binding: FindPwdBinding(),
      transitionDuration: Duration(milliseconds: 300),
      transition: Transition.rightToLeftWithFade
    ),
  ];

  // 找不到去登录页
  static final unknownRoute = GetPage(
    name: AppRoutes.login,
    page: () => LoginView(),
    transitionDuration: Duration(milliseconds: 300),

  );
}