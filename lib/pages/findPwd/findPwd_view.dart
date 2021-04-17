import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/pages/findPwd/findPwd.controller.dart';

class FindPwdView extends GetView<FindPwdController> {

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

  Widget _buildContent() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      width: Get.width,
      child: Column(
        children: [
          _buildTitle(),
          _buildExplan(),
          _buildInput(),
          _buildNext(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 3),
      alignment: Alignment.centerLeft,
      width: 0.82.sw,
      child: Text(
        '找回密码',
        style: TextStyle(
            fontSize: 26, color: Colors.black87, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildExplan() {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 30),
      alignment: Alignment.centerLeft,
      width: 0.82.sw,
      child: Text(
        '为了保障您的账户安全，1天只能操作1次，否则账户将会被锁定无法登录',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 40),
      child: Obx(() =>ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 48.h, maxWidth: 0.82.sw),
        child: TextField(
          controller: controller.phoneController,
          maxLines: 1,
          autocorrect: true,
          //是否自动更正
          autofocus: true,
          //是否自动对焦
          textAlign: TextAlign.start,
          //文本对齐方式
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
            prefixIcon: Container(
              width: 80.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('+86'),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black87,
                    size: 20,
                  ),
                  VerticalDivider(
                    width: .5,
                    thickness: .5,
                    indent: 8,
                    endIndent: 8,
                    color: Colors.grey[300],
                  )
                ],
              ),
            ),
            suffixIcon: controller.isShowDel
                ? GestureDetector(
              child:
              Icon(Iconfont.close, color: Colors.blue, size: 16),
              onTap: () {
                controller.phoneController.clear();
                controller.setPhone('');
              },
            )
                : null,
            // contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          onChanged: (text) {
            //内容改变的回调
            controller.setPhone(text);
          },
          onSubmitted: (text) {
            //内容提交(按回车)的回调
            LogUtils.GGQ('phone onSubmitted:${text}');
          },
        ),
      )),
    );
  }

  Widget _buildNext() {
    return Container(
      width: 0.82.sw,
      child: Obx(() => ElevatedButton(
          onPressed: controller.isShowDel ? () {} : null,
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
              '下一步',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ))),
    );
  }
}
