import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/input/remark_input.dart';
import 'package:getx_app/pages/ownerInfo/ownerInfo_controller.dart';

class OwnerInfoView extends GetView<OwnerInfoController>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white ,
        elevation: 0.0,
        title: Text('车主信息填写',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
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
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        child: SingleChildScrollView(
          controller: controller.controller,
          child: _buildInfo(context),
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context){
    return Column(
      children: [
        GetBuilder<OwnerInfoController>(
            id: 'expand',
            builder: (_) => ExpansionPanelList(
              elevation: 0,
              dividerColor: Colors.grey[50],
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (int panelIndex, bool isExpanded) => controller.expansionCallback(panelIndex, isExpanded),
              animationDuration: const Duration(milliseconds: 500),
              children: <ExpansionPanel>[
                ExpansionPanel(
                    isExpanded: controller.isBasicExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) => Container(child: Text('基本信息',style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.bold),),padding: EdgeInsets.only(left: 20.w),alignment: Alignment.centerLeft,),
                    backgroundColor: Colors.white,
                    canTapOnHeader: true,
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      width: Get.width,
                      child: Column(
                        children: [
                          _buildIDCard(),
                          _buildOwnerName(),
                          _buildGender(context),
                          _buildBirthday(context),
                          _buildOwnerPhone(),
                          _buildResAddress(),
                          _buildDivider(),
                        ],
                      ),
                    )
                ),
                ExpansionPanel(
                    isExpanded: controller.isContactExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) => Container(child: Text('紧急联系人信息',style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.bold),),padding: EdgeInsets.only(left: 20.w),alignment: Alignment.centerLeft,),
                    backgroundColor: Colors.white,
                    canTapOnHeader: true,
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      width: Get.width,
                      child: Column(
                        children: [
                          _buildContactName(),
                          _buildContactPhone()
                        ],
                      ),
                    )
                ),
              ],
            )),
        _buildNext(),
      ],
    );
  }

  Widget _buildDivider(){
    return Divider(
      height: .5,
        thickness: .5,
      color: Colors.grey[100],
    );
  }

  Widget _buildIDCard(){
    return Container(
        padding: EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Text('身份证号码',style: TextStyle(fontSize: 14,color: Colors.black87),),
                    Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),
                  ],
                ),
              ),flex: OwnerInfoController.FLEX_TITLE,
            ),
            Expanded(
              child: Container(
                child: TextField(
                  controller: controller.idController,
                  maxLines: 1,
                  autocorrect: true,//是否自动更正
                  // autofocus: true,//是否自动对焦
                  textAlign: TextAlign.start,//文本对齐方式
                  obscureText: false,//是否是密码
                  keyboardType: TextInputType.numberWithOptions(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                    hintText: '请输入身份证号码',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  onChanged: (text) {//内容改变的回调

                  },
                  onSubmitted: (text) {//内容提交(按回车)的回调
                    LogUtils.GGQ('idcard onSubmitted:${text}');
                  },
                ),
              ),
              flex: OwnerInfoController.FLEX_CONTENT,
            ),
          ],
        ),
    );
  }

  Widget _buildOwnerName(){
    return Container(
      padding: controller.itemPadding,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text('车主姓名',style: TextStyle(fontSize: 14,color: Colors.black87),),
                  Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),
                ],
              ),
            ),flex: OwnerInfoController.FLEX_TITLE,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: controller.nameController,
                maxLines: 1,
                autocorrect: true,//是否自动更正
                // autofocus: true,//是否自动对焦
                textAlign: TextAlign.start,//文本对齐方式
                obscureText: false,//是否是密码
                keyboardType: TextInputType.name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                  hintText: '请输入车主姓名',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (text) {//内容改变的回调

                },
                onSubmitted: (text) {//内容提交(按回车)的回调
                  LogUtils.GGQ('idcard onSubmitted:${text}');
                },
              ),
            ),
            flex: OwnerInfoController.FLEX_CONTENT,
          ),
        ],
      ),
    );
  }
  Widget _buildGender(BuildContext context){
    return Container(
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Text('性别',style: TextStyle(fontSize: 14,color: Colors.black87),),
                    Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),
                  ],
                ),
              ),flex: OwnerInfoController.FLEX_TITLE,
            ),
            Expanded(
              child: Container(
                padding: controller.itemPadding,
                child: Row(
                  children: [
                    Expanded(child: Text('男',style: TextStyle(fontSize: 14,color: Colors.black87),)),
                    Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.grey[300],),
                  ],
                ),
              ),
              flex: OwnerInfoController.FLEX_CONTENT,
            ),
          ],
        ),
        splashColor: Colors.blue[50],
        focusColor: Colors.blue[50],
        highlightColor: Colors.blue[50],
        onTap: (){
          // Get.snackbar('', '性别');
          controller.showChooseGenderDialog(context);
        },
      ),
    );
  }
  Widget _buildBirthday(BuildContext context){
    return Container(
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Text('出生日期',style: TextStyle(fontSize: 14,color: Colors.black87),),
                    Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),
                  ],
                ),
              ),flex: OwnerInfoController.FLEX_TITLE,
            ),
            Expanded(
              child: Container(
                padding: controller.itemPadding,
                child: Row(
                  children: [
                    Expanded(child: Text('1990-10-09',style: TextStyle(fontSize: 14,color: Colors.black87),)),
                    Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.grey[300],),
                  ],
                ),
              ),
              flex: OwnerInfoController.FLEX_CONTENT,
            ),
          ],
        ),
        splashColor: Colors.blue[50],
        focusColor: Colors.blue[50],
        highlightColor: Colors.blue[50],
        onTap: (){
         // Get.snackbar('', '出生日期');
          controller.showChooseDateDialog(context);
        },
      ),
    );
  }
  Widget _buildOwnerPhone(){
    return Container(
      padding: controller.itemPadding,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text('车主手机号',style: TextStyle(fontSize: 14,color: Colors.black87),),
                  Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),
                ],
              ),
            ),flex: OwnerInfoController.FLEX_TITLE,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: controller.phoneController,
                maxLines: 1,
                autocorrect: true,//是否自动更正
                // autofocus: true,//是否自动对焦
                textAlign: TextAlign.start,//文本对齐方式
                obscureText: false,//是否是密码
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                  hintText: '请输入车主手机号码',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (text) {//内容改变的回调

                },
                onSubmitted: (text) {//内容提交(按回车)的回调
                  LogUtils.GGQ('idcard onSubmitted:${text}');
                },
              ),
            ),
            flex: OwnerInfoController.FLEX_CONTENT,
          ),
        ],
      ),
    );
  }
  Widget _buildResAddress(){
    return Container(
      padding: controller.itemPadding,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Text('现居住地',style: TextStyle(fontSize: 14,color: Colors.black87),),
                Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: RemarkInput(
              height: 92,
              placeholder: '请输入现居住地',
              onChanged: (String txt){
                // inputText = txt;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContactName(){
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text('紧急联系人',style: TextStyle(fontSize: 14,color: Colors.black87),),
                  Visibility(child: Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),visible: false,)
                ],
              ),
            ),flex: OwnerInfoController.FLEX_TITLE,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: controller.contactNameController,
                maxLines: 1,
                autocorrect: true,//是否自动更正
                // autofocus: true,//是否自动对焦
                textAlign: TextAlign.start,//文本对齐方式
                obscureText: false,//是否是密码
                keyboardType: TextInputType.name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                  hintText: '请输入紧急联系人姓名',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (text) {//内容改变的回调

                },
                onSubmitted: (text) {//内容提交(按回车)的回调
                  LogUtils.GGQ('idcard onSubmitted:${text}');
                },
              ),
            ),
            flex: OwnerInfoController.FLEX_CONTENT,
          ),
        ],
      ),
    );
  }
  Widget _buildContactPhone(){
    return Container(
      padding: controller.itemPadding,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text('紧急联系人电话',style: TextStyle(fontSize: 14,color: Colors.black87),),
                  Visibility(child: Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),visible: false,)
                ],
              ),
            ),flex: OwnerInfoController.FLEX_TITLE,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: controller.contactPhoneController,
                maxLines: 1,
                autocorrect: true,//是否自动更正
                // autofocus: true,//是否自动对焦
                textAlign: TextAlign.start,//文本对齐方式
                obscureText: false,//是否是密码
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                  hintText: '请输入紧急联系人电话',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (text) {//内容改变的回调

                },
                onSubmitted: (text) {//内容提交(按回车)的回调
                  LogUtils.GGQ('idcard onSubmitted:${text}');
                },
              ),
            ),
            flex: OwnerInfoController.FLEX_CONTENT,
          ),
        ],
      ),
    );
  }

  Widget _buildNext(){
    return Container(
      margin: EdgeInsets.only(top: 30,bottom: 20),
      width: 0.62.sw,
      height: 44.h,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            side: BorderSide(width: 1, color: Colors.grey[200]),
          ),
          onPressed: (){
            controller.onNext();
          },
          child: Text('下一步',style: TextStyle(color: Colors.black54,fontSize: 14),)
      ),
    );
  }

}