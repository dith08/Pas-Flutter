import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pas1_mobile_11pplg1_30/bottomnav/bottomnav.dart';
import 'package:pas1_mobile_11pplg1_30/login/login_view.dart';
import 'package:pas1_mobile_11pplg1_30/profile/profile_controller.dart';
import 'package:pas1_mobile_11pplg1_30/register/register_controller.dart';
import 'package:pas1_mobile_11pplg1_30/splashscreen/splashscreen_controller.dart';
import 'package:pas1_mobile_11pplg1_30/login/login_controller.dart';
import 'package:pas1_mobile_11pplg1_30/splashscreen/splashscren_view.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(SplashController());
        Get.put(ApiloginControllerr());
      }),
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashScreen(),
          binding: BindingsBuilder(() {
            Get.put(SplashController());
          }),
        ),
        GetPage(
          name: '/login',
          page: () => LoginView(),
          binding: BindingsBuilder(() {
            Get.put(ApiloginControllerr());
          }),
        ),
        GetPage(
          name: '/home',
          page: () => const BottomNav(),
          binding: BindingsBuilder(() {
            Get.put(RegisterController());
            Get.put(ProfileController());
          }),
        ),
      ],
    );
  }
}
