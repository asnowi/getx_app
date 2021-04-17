import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/iconfont.dart';
import 'package:getx_app/pages/home/home_controller.dart';
import 'package:getx_app/pages/main/main_view.dart';
import 'package:getx_app/pages/mine/mine_view.dart';

class HomeView extends GetView<HomeController> {

  DateTime _popTime;

  final PageController _pageController = PageController(initialPage: 0,keepPage: true);

  final _pageList = [
    MainView(),
    MineView()
  ];

  final _defaultIcon = [
    Iconfont.home,
    Iconfont.mine
  ];

  final _selectedIcon = [
    Iconfont.selHome,
    Iconfont.selMine
  ];

  final List<String> _textList= [
    '首页',
    '我的',
  ];



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        extendBody: false,
        resizeToAvoidBottomInset: false,
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomAppBar(context),
      ),
      onWillPop: () async {
        if(_popTime == null || DateTime.now().difference(_popTime) > Duration(seconds: 1)){
          //两次点击时间间隔超过1秒则重新计时
          _popTime = DateTime.now();
          // ToastUtils.showToast('再按一次退出');
          Get.snackbar('', '再按一次退出');
          return false;
        }
        return true;
      },
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: _pageList,
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    final itemWidth = Get.width /2;
    return BottomAppBar(
      elevation: 2,
      child: Row(
        children: [
          SizedBox(height: 48, width: itemWidth, child: _buildItemBar(0)),
          SizedBox(height: 48, width: itemWidth, child: _buildItemBar(1)),
        ],
      ),
    );
  }

  Widget _buildItemBar(int index){
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Obx(() => Icon(controller.currentIndex == index ? _selectedIcon[index]: _defaultIcon[index],color: controller.currentIndex == index ? Colors.blue: Colors.black54,size: 19,)),
            Obx(() => Text(_textList[index],style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: controller.currentIndex == index ? Colors.blue: Colors.black54,
            )
            ))
          ],
        ),
        onTap: () {
          controller.selectedItem(index);
          _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);//跳转动画
        },
      ),
    );
  }
}