import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/widget/box/verification_box.dart';
import 'package:getx_app/common/widget/box/verification_box_item.dart';
import 'package:getx_app/common/widget/input/grid_input.dart';
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
        ],
      ),
    );
  }

  Widget _buildInput(){
    return Container(
      height: 45,
      child: VerificationBox(
        count: 4,
        type: VerificationBoxItemType.underline,
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
    //
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