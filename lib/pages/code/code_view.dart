import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/widget/box/verification_box.dart';
import 'package:getx_app/common/widget/box/verification_box_item.dart';
import 'package:getx_app/pages/code/code_controller.dart';
import 'package:getx_app/common/utils/index.dart';

class CodeView extends GetView<CodeController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
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
  Widget _buildContent(){
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      width: Get.width,
      child: Column(
        children: [
          _buildTitle(),
          _buildSubTitle(),
          _buildInput(),
          _buildTimer(),
        ],
      ),
    );
  }

  Widget _buildInput(){
    return Container(
      height: 45,
      child: VerificationBox(
        controller: controller.controller,
        count: 4,
        textStyle: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        showCursor: true,
        cursorColor: Colors.blue,
        type: VerificationBoxItemType.underline,
        borderColor: Colors.grey[300],
        focusBorderColor: Colors.grey,
        onSubmitted: (value){
          Get.snackbar('', '${value}');
          controller.onSubmitted(value,controller.phone);
        },
      ),
    );
  }

  Widget _buildTimer(){
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: 40.h
      ),
      child: Container(
        width: 0.82.sw,
        alignment: Alignment.centerLeft,
        child: GetBuilder<CodeController>(
          id: 'timer',
          builder: (_) => RichText(
            text: TextSpan(
              text: controller.timeCount,
              style: TextStyle(color: Colors.blue, fontSize: 12),
              children: [
                TextSpan(
                  text: '秒后',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),

                TextSpan(
                    text: '重新发送',
                    style: TextStyle(
                        color: controller.sendColor,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                        recognizer: TapGestureRecognizer() ..onTap = controller.isAllow? () {
                          //Get.snackbar('','重新发送');
                          controller.sendCodeByPhone(controller.phone);
                        }: null,
                ),
                TextSpan(
                  text: '验证码',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 3),
      alignment: Alignment.centerLeft,
      width: 0.82.sw,
      child: Text(
        '请输入验证码',
        style: TextStyle(
            fontSize: 26,
            color: Colors.black87,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buildSubTitle() {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 30),
      alignment: Alignment.centerLeft,
      width: 0.82.sw,
        child: GetBuilder<CodeController>(
          id: 'subTitle',
          builder: (_) => Text(
            controller.subTitle,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12
            ),
          ),
        ),
    );
  }


}