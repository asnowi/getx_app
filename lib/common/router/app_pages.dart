
import 'package:get/get.dart';
import 'package:getx_app/pages/bdmap/bdmap_binding.dart';
import 'package:getx_app/pages/bdmap/bdmap_view.dart';
import 'package:getx_app/pages/code/code_binding.dart';
import 'package:getx_app/pages/code/code_view.dart';
import 'package:getx_app/pages/ebikeInfo/ebikeInfo_binding.dart';
import 'package:getx_app/pages/ebikeInfo/ebikeInfo_view.dart';
import 'package:getx_app/pages/findPwd/findPwd_binding.dart';
import 'package:getx_app/pages/findPwd/findPwd_view.dart';
import 'package:getx_app/pages/home/home_binding.dart';
import 'package:getx_app/pages/home/home_view.dart';
import 'package:getx_app/pages/locus/locus_binding.dart';
import 'package:getx_app/pages/locus/locus_view.dart';
import 'package:getx_app/pages/login/login_binding.dart';
import 'package:getx_app/pages/login/login_view.dart';
import 'package:getx_app/pages/ownerInfo/ownerInfo_binding.dart';
import 'package:getx_app/pages/ownerInfo/ownerInfo_view.dart';
import 'package:getx_app/pages/resetPwd/resetPwd_binding.dart';
import 'package:getx_app/pages/resetPwd/resetPwd_view.dart';
import 'package:getx_app/pages/splash/splash_view.dart';
import 'package:getx_app/pages/userIDCard/userIDCard_binding.dart';
import 'package:getx_app/pages/userIDCard/userIDCard_view.dart';
import 'package:getx_app/pages/welcome/welcome_binding.dart';
import 'package:getx_app/pages/welcome/welcome_view.dart';

part 'app_routes.dart';
class AppPages {
  static const INITIAL = AppRoutes.splash;

  static final List<GetPage> routes = [

    GetPage(
        name: AppRoutes.splash,
        page: () => SplashView(),
    ),

    GetPage(
      name: AppRoutes.welcome,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
      transition: Transition.rightToLeftWithFade
    ),

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
    ),

    GetPage(
      name: AppRoutes.findPwd,
      page: () => FindPwdView(),
      binding: FindPwdBinding(),
      transitionDuration: Duration(milliseconds: 300),
      transition: Transition.rightToLeftWithFade
    ),

    GetPage(
        name: AppRoutes.code,
        page: () => CodeView(),
        binding: CodeBinding(),
        transitionDuration: Duration(milliseconds: 300),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(
        name: AppRoutes.resetPwd,
        page: () => ResetPwdView(),
        binding: ResetPwdBinding(),
        transitionDuration: Duration(milliseconds: 300),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(
        name: AppRoutes.userIDCard,
        page: () => UserIDCardView(),
        binding: UserIDCardBinding(),
        transitionDuration: Duration(milliseconds: 300),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(
        name: AppRoutes.ownerInfo,
        page: () => OwnerInfoView(),
        binding: OwnerInfoBinding(),
        transitionDuration: Duration(milliseconds: 300),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(
        name: AppRoutes.ebikeInfo,
        page: () => EbikeInfoView(),
        binding: EbikeInfoBinding(),
        transitionDuration: Duration(milliseconds: 300),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(
        name: AppRoutes.bdmap,
        page: () => BDMapView(),
        binding: BDMapBinding(),
        transitionDuration: Duration(milliseconds: 300),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(
        name: AppRoutes.locus,
        page: () => LocusView(),
        binding: LocusBinding(),
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