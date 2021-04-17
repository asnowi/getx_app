
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/main/main_controller.dart';

class MainView extends GetView<MainController> {

  @override
  MainController get controller => Get.put(MainController());

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        child: Text('main'),
      ),
    );
  }
}
