import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/resetPwd/resetPwd_controller.dart';
import 'package:getx_app/common/utils/index.dart';

class ResetPwdView extends GetView<ResetPwdController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: Config.backRadius,
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.grey,
          ),
        ),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      width: Get.width,
      child: Column(
        children: [
          _buildTitle(),
          _buildSubTitle(),
          _buildInput(),
          _buildSubmit(),
        ],
      ),
    );
  }

  Widget _buildInput(){
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 40),
      child: GetBuilder<ResetPwdController>(
        id: 'input',
        builder: (_) => ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 48.h,maxWidth: 0.82.sw),
          child: TextField(
            controller: controller.inputController,
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
              hintText: '请输入新密码',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              prefixIcon: const Icon(Iconfont.pwd,color: Colors.blue,size: 16),
              suffixIcon: controller.hasEye? GestureDetector(
                child: Icon(controller.eyeAction? Iconfont.eyeShow: Iconfont.eyeHide,color: Colors.blue,size: 16),
                onTap: (){
                  controller.changeEyeAction(!controller.eyeAction);
                },
              ):null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            onChanged: (text) {//内容改变的回调
              controller.changeHasEye(text.isNotEmpty);
            },
            onSubmitted: (text) {//内容提交(按回车)的回调
              LogUtils.GGQ('password onSubmitted:${text}');
            },
          ),
        ),
      ),
    );
  }


  Widget _buildSubmit(){
    return Container(
      width: 0.82.sw,
      child: GetBuilder<ResetPwdController>(
        id: 'input',
        builder: (_) =>ElevatedButton(
            onPressed: controller.inputController.text.isBlank? null :(){
                LogUtils.GGQ('手机号->${controller.phone}');
                controller.onSubmit();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.blue[100];
                  }
                  return Colors.blue;
                })),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text(
                '完成',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildTitle(){
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 3),
      alignment: Alignment.centerLeft,
      width: 0.82.sw,
      child: Text(
        '重新设置密码',
        style: TextStyle(
            fontSize: 26,
            color: Colors.black87,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buildSubTitle(){
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 30),
      alignment: Alignment.centerLeft,
      width: 0.82.sw,
      child: Text('8-20个字符',style: TextStyle(
          color: Colors.grey,
          fontSize: 12
      ),),
    );
  }

}