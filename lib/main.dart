import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_signalr_chat/app/modules/home/bindings/home_binding.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/routes/app_pages.dart';


void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: HomeBinding(),
      onInit: ()  {
        Get.find<HomeController>().startConnection();
      },
    ),
  );
}
