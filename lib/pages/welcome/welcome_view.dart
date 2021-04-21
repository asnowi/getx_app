import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/pages/welcome/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController>{

  List<Widget> _list(context) {
    return [
      _buildWelcome(context,1),
      _buildWelcome(context,2),
      _buildWelcome(context,3),
      _buildWelcome(context,4),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        width: Get.width,
        height: Get.height,
        child: PageView(
          scrollDirection: Axis.horizontal,
          reverse: false,
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
            keepPage: true,
          ),
          physics:BouncingScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            //监听事件
            LogUtils.GGQ('index=====$index');
          },
          children: _list(context),
        ),
      ),
    );
  }

  Widget _buildWelcome(BuildContext context,int index){
    if(index == 1) return Image.asset(AssetsProvider.imagePath('welcome1',type: 'jpg'),fit: BoxFit.cover);
    if(index == 2) return Image.asset(AssetsProvider.imagePath('welcome2',type: 'jpg'),fit: BoxFit.cover);
    if(index == 3) return Image.asset(AssetsProvider.imagePath('welcome3',type: 'jpg'),fit: BoxFit.cover);
    else return GestureDetector(
        child: Image.asset(AssetsProvider.imagePath('welcome4',type: 'jpg'),fit: BoxFit.cover),
        onTap: (){
            controller.launchHome();
        },
    );
  }

}