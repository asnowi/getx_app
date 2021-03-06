import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getx_app/common/config/const.dart';
import 'package:getx_app/common/db/index.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/global.dart';
import 'package:getx_app/pages/login/login_controller.dart';

class LoginView extends GetView<LoginController> {

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,// 解决键盘顶起页面
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Obx(() =>AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, anim) {
            return ScaleTransition(child: child, scale: anim);
          },
          child: IconButton(
            key: UniqueKey(),
            onPressed: () {
              controller.changeClose(!controller.isClose);
              // Get.back();
            },
            icon: Icon(
              controller.isClose? Icons.close:Icons.close,
              color: Colors.black,
            ),
          ),
        )),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Get.snackbar('', '帮助');
              },
              child: Text('帮助',
                  style: TextStyle(color: Colors.black, fontSize: 14)))
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent(){
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      width: Get.width,
      child: Flex(
        direction: Axis.vertical,
        children: [
          _buildTop(),
          _buildWrap(userNameController,passwordController),
          _buildAgreement()
        ],
      ),
    );
  }


  Widget _buildTop(){
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text('平安电车',style: TextStyle(
            fontSize: 26,
            color: Colors.black87,
            fontWeight: FontWeight.bold
        ),)),
    );
  }

  Widget _buildUserNameTextField(TextEditingController textController) {
    final String _phone = '13717591366';
    if(_phone != null && _phone.isNotEmpty){
      textController.text = _phone;
      controller.changePhoneDel(true);
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 48.h,
          maxWidth: 0.82.sw
      ),
      child: Obx(() => TextField(
        controller: textController,
        maxLines: 1,
        autocorrect: true,//是否自动更正
        autofocus: true,//是否自动对焦
        textAlign: TextAlign.start,//文本对齐方式
        keyboardType: TextInputType.phone,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          hintText: '请输入手机号',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          prefixIcon: const Icon(Iconfont.phone,color: Colors.blue,size: 16),
          suffixIcon: controller.isPhoneDel? GestureDetector(
            child: Icon(Iconfont.close,color: Colors.blue,size: 16),
            onTap: (){
              textController.clear();
              controller.changePhoneDel(false);
            },
          ): null,
          // contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        onChanged: (text) {//内容改变的回调
          controller.changePhoneDel(text.isNotEmpty);
        },
        onSubmitted: (text) {//内容提交(按回车)的回调
          LogUtils.GGQ('phone onSubmitted:${text}');
        },
      )),
    );
  }

  Widget _buildPasswordTextField(TextEditingController textController) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 48.h,
          maxWidth: 0.82.sw
      ),
      child: Obx(()=>TextField(
        controller: textController,
        maxLines: 1,
        autocorrect: true,//是否自动更正
        // autofocus: true,//是否自动对焦
        textAlign: TextAlign.start,//文本对齐方式
        obscureText: !controller.eyeAction,//是否是密码
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          hintText: '请输入密码',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          prefixIcon: const Icon(Iconfont.pwd,color: Colors.blue,size: 16),
          // suffixIcon: accountController.hasEye.value? Icon(accountController.eyeShow.value? Iconfont.eye_show: Iconfont.eye_hide,color: Colors.redAccent,size: 18):null,
          suffixIcon: controller.hasEye? GestureDetector(
            child: Icon(controller.eyeAction? Iconfont.eyeShow: Iconfont.eyeHide,color: Colors.blue,size: 16),
            onTap: (){
              controller.onEyeAction();
            },
          ):null,
          // contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        onChanged: (text) {//内容改变的回调
          controller.changeEye(text.isNotEmpty);
        },
        onSubmitted: (text) {//内容提交(按回车)的回调
          LogUtils.GGQ('password onSubmitted:${text}');
        },
      )),
    );
  }

  Widget _buildLogin(TextEditingController userNameController, TextEditingController passwordController) {
    return Container(
      width: 0.82.sw ,
      child: Obx(() => ElevatedButton(onPressed: controller.hasLogin? (){

        if(!controller.isAgree){
          Get.snackbar('请同意', '请您认真阅读并同意《用户使用协议》及《隐私条款》');
          return;
        }

        if(!RegexUtils.isPhone(userNameController.text)){
          Get.snackbar('', '您输入的手机号格式不正确');
          return;
        }
        _onLogin(userNameController.text,passwordController.text);
      }:null,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states){
                if(states.contains(MaterialState.disabled)){
                  return Colors.blue[100];
                }
                return Colors.blue;
              })
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text('登录',style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
          )
      )),
    );
  }

  Widget _buildForgotPassword(TextEditingController userNameController){
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: 0.82.sw
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(onPressed: (){
            final phone = userNameController.text;
            Get.toNamed(AppRoutes.findPwd,arguments: {'phone': phone});
        }, child: Text('忘记密码?',style: TextStyle(fontSize: 14,color: Colors.grey),)),
      ),
    );
  }

  Widget _buildWrap(TextEditingController userNameController,TextEditingController passwordController){
    return Column(
      children: [
        _buildUserNameTextField(userNameController),
        SizedBox(height: 20.h),
        _buildPasswordTextField(passwordController),
        SizedBox(height: 30.h),
        _buildLogin(userNameController,passwordController),
        _buildForgotPassword(userNameController),
      ],
    );
  }

  Widget _buildAgreement(){
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: InkWell(
                child: Obx(() => controller.isAgree? Icon(Icons.radio_button_on,size: 18,color: Colors.blue,): Icon(Icons.radio_button_off,size: 18,color: Colors.grey,)),
                onTap: (){
                  controller.changeAgree(!controller.isAgree);
                },
                splashColor: Colors.blue[50],
                focusColor: Colors.blue[50],
                highlightColor: Colors.blue[50],
              ),
            ),

            RichText(
              text: TextSpan(
                  text: '我已认真阅读并同意',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                  children: [
                    TextSpan(
                        text: "《用户使用协议》",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer() ..onTap = () async {
                              // Toast.show('用户使用协议');
                              Get.snackbar('','用户使用协议');
                            }
                    ),
                    TextSpan(
                        text: "及",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.italic)),
                    TextSpan(
                        text: "《隐私条款》",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer() ..onTap = () async {
                              //Toast.show('隐私条款');
                              Get.snackbar('','隐私条款');
                            }
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onLogin(String phone, String password) async{

    //登录成功
    final token = 'token-01110';

    final user = User()
      ..userId = '01'
      ..token = token
      ..phone = phone
      ..avatarImg = 'http://p1.music.126.net/GE2kVDwdVQyoNJC8k31mEA==/18979769718754963.jpg';

    final res = await Global.dbUtil.userBox.add(user);
    LogUtils.GGQ('登录->${res}');
    Global.userInfo = user;
    LogUtils.GGQ('user->${Global.userInfo.toString()}');
    //发送事件
    final event = CommonEvent(EventCode.EVENT_LOGIN,message: res.toString());
    EventBusUtils.send(event);

    Get.back();
  }
}
