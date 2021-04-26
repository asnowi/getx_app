import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/config/const.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/assets.dart';
import 'package:getx_app/common/utils/iconfont.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/global.dart';
import 'package:getx_app/pages/mine/mine_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MineView extends GetView<MineController> {

  @override
  MineController get controller => Get.put(MineController());

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return _buildHeader(context,innerBoxIsScrolled);
        },
        body: _buildContent(context),
    );
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
          collapsedHeight: 142.h,
          expandedHeight: 142.h,
          elevation: .8,
          floating: true,
          pinned: true,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  // child: _buildUserHead(),
                  child: Obx(()=> controller.isLogin? _buildUserHead() : _buildUnLogin()),
                );
              })),
    ];
  }

  Widget _buildContent(BuildContext context){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Card(
            elevation: 2.2,//阴影
            shape: const RoundedRectangleBorder(//形状
              //修改圆角
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            color: Colors.white, //颜色
            margin: EdgeInsets.symmetric(horizontal: 14,vertical: 20), //margin
            child: Column(
              children: [
                InkWell(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconfont.myData,size: 16,),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                        Expanded(child: Text('我的资料',style: TextStyle(color: Colors.black87,fontSize: 12),),flex: 1,),
                        Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.grey[300],),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(14, 18, 14, 10),
                  ),
                  splashColor: Colors.blue[50],
                  focusColor: Colors.blue[50],
                  highlightColor: Colors.blue[50],
                  onTap: (){
                    if(controller.isLogin){
                      // Get.snackbar('', '我的资料');
                      Get.toNamed(AppRoutes.bdmap);
                    }else{
                      Get.toNamed(AppRoutes.login);
                    }
                  },
                ),

                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  indent: 30.w,
                ),

                InkWell(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconfont.changePwd,size: 16,),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                        Expanded(child: Text('修改密码',style: TextStyle(color: Colors.black87,fontSize: 12),),flex: 1,),
                        Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.grey[300],),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(14, 10, 14, 18),
                  ),
                  splashColor: Colors.blue[50],
                  focusColor: Colors.blue[50],
                  highlightColor: Colors.blue[50],
                  onTap: (){
                    if(controller.isLogin){
                     // Get.snackbar('', '修改密码');
                      Get.toNamed(AppRoutes.locus);
                    }else{
                      Get.toNamed(AppRoutes.login);
                    }
                  },
                )
              ],
            ),
          ),

          TextButton(onPressed: () async{
            if(controller.isLogin){
              // Get.snackbar('', '退出');
              int res = await Global.dbUtil.userBox.clear();
              LogUtils.GGQ('退出登录->${res}');
              Global.userInfo = null;
              final event = CommonEvent(EventCode.EVENT_LOGIN,message: res.toString());
              EventBusUtils.send(event);
            }else{
              Get.toNamed(AppRoutes.login);
            }
          }, child: Container(
            alignment: Alignment.center,
            width: 0.9.sw,
            height: 30.h,
            child: Obx(() => controller.isLogin? Text('退出登录',style: TextStyle(fontSize: 14,color: Colors.black87),): Text('登录',style: TextStyle(fontSize: 14,color: Colors.black87),)),
          ),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue[50])
          ),)
        ],
      ),
    );
  }
  Widget _buildUnLogin(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(72,72)),
            child: Image.asset(AssetsProvider.imagePath('img_avatar_default')),
          ) ,
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
        Container(
          child: TextButton(
            onPressed: (){
              Get.toNamed(AppRoutes.login);
            },
            child: Text('请先登录',style: TextStyle(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)
            ),
          ),
        )
      ],
    );
  }
  Widget _buildUserHead() {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: ConstrainedBox(
              constraints: BoxConstraints.loose(Size(72,72)),
              child: (controller.getUser() != null && controller.getUser().avatarImg != null)? ImageLoader.load(url: controller.getUser().avatarImg): Image.asset(AssetsProvider.imagePath('img_avatar_default')),
            ) ,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
          Container(
            width: Get.width /2,
            child: Column(
              children: [
                Text((controller.getUser() != null && controller.getUser().phone != null)?  controller.getUser().phone:'',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Colors.black87),),
                Text((controller.getUser() != null && controller.getUser().avatarImg != null)? controller.getUser().avatarImg:'',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: Colors.black87),),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          )
        ],
      ),
      onTap: (){
        Get.snackbar('', controller.getUser().avatarImg);
      },
    );
  }
}

