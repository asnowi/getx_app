import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class UserIDCardController extends GetxController{

  final ScrollController controller = ScrollController();


  Future<void> applyPermissions() async{
    if(await Permission.camera.status.isGranted){

    }else{
     // await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

}