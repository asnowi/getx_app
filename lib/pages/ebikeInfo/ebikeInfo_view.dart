import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/widget/input/remark_input.dart';
import 'package:getx_app/pages/ebikeInfo/ebikeInfo_controller.dart';
import 'package:getx_app/common/utils/index.dart';

class EbikeInfoView extends GetView<EbikeInfoController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white ,
        elevation: 0.0,
        title: Text('车辆信息填写',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
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
        GetBuilder<EbikeInfoController>(
            id: 'expand',
            builder: (_) => ExpansionPanelList(
              elevation: 0,
              dividerColor: Colors.grey[50],
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (int panelIndex, bool isExpanded) => controller.expandCallback(panelIndex, isExpanded),
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
                          _buildDeviceNo(),
                          _buildEbikeNo(),
                          _buildFrameNo(),
                          _buildEngineNo(),
                          _buildBrand(context),
                          _buildColor(),
                          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                          _buildDivider(),
                        ],
                      ),
                    )
                ),
                ExpansionPanel(
                    isExpanded: controller.isBuyExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) => Container(child: Text('购买信息',style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.bold),),padding: EdgeInsets.only(left: 20.w),alignment: Alignment.centerLeft,),
                    backgroundColor: Colors.white,
                    canTapOnHeader: true,
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      width: Get.width,
                      child: Column(
                        children: [
                          _buildBuyPrice(),
                          _buildBuyDate(context),
                          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                          _buildDivider()
                        ],
                      ),
                    )
                ),
                ExpansionPanel(
                    isExpanded: controller.isSafeExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) => Container(child: Text('保险信息',style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.bold),),padding: EdgeInsets.only(left: 20.w),alignment: Alignment.centerLeft,),
                    backgroundColor: Colors.white,
                    canTapOnHeader: true,
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      width: Get.width,
                      child: Column(
                        children: [
                          _buildSafeService(),
                          _buildSafeContent(),
                          _buildDivider()
                        ],
                      ),
                    )
                ),
              ],
            )),
        _buildRemark(),
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

  Widget _buildDeviceNo(){
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text('定位设备编号',style: TextStyle(fontSize: 14,color: Colors.black87),),
                  Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),
                ],
              ),
            ),flex: EbikeInfoController.FLEX_TITLE,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container(
                  child: TextField(
                    controller: controller.deviceNoController,
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
                      hintText: '请输入定位设备编号',
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
                ),),
                IconButton(
                  splashRadius: 20,
                  onPressed: (){},
                  tooltip: '点击扫描设备编码',
                  icon: Icon(Iconfont.scan,size: 20,color: Colors.blue,),
                )
              ],
            ),
            flex: EbikeInfoController.FLEX_CONTENT,
          ),
        ],
      ),
    );
  }

  Widget _buildEbikeNo(){
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text('车牌号',style: TextStyle(fontSize: 14,color: Colors.black87),),
                  Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),
                ],
              ),
            ),flex: EbikeInfoController.FLEX_TITLE,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: controller.ebikeNoController,
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
                  hintText: '请输入车牌号',
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
                  LogUtils.GGQ('ebike no onSubmitted:${text}');
                },
              ),
            ),
            flex: EbikeInfoController.FLEX_CONTENT,
          ),
        ],
      ),
    );
  }
  Widget _buildFrameNo(){
    return Container(
      padding: controller.itemPadding,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text('车架号',style: TextStyle(fontSize: 14,color: Colors.black87),),
                  Visibility(child: Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),visible: false,),
                ],
              ),
            ),flex: EbikeInfoController.FLEX_TITLE,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: controller.frameNoController,
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
                  hintText: '请输入车架号',
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
                  LogUtils.GGQ('frame no onSubmitted:${text}');
                },
              ),
            ),
            flex: EbikeInfoController.FLEX_CONTENT,
          ),
        ],
      ),
    );
  }

  Widget _buildEngineNo(){
    return Container(
      padding: controller.itemPadding,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text('发动机号',style: TextStyle(fontSize: 14,color: Colors.black87),),
                  Visibility(child: Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),visible: false,),
                ],
              ),
            ),flex: EbikeInfoController.FLEX_TITLE,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: controller.engineNoController,
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
                  hintText: '请输入发动机号',
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
                  LogUtils.GGQ('frame no onSubmitted:${text}');
                },
              ),
            ),
            flex: EbikeInfoController.FLEX_CONTENT,
          ),
        ],
      ),
    );
  }
  
  Widget _buildBrand(BuildContext context){
    return Container(
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Text('品牌',style: TextStyle(fontSize: 14,color: Colors.black87),),
                    Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,)
                  ],
                ),
              ),flex: EbikeInfoController.FLEX_TITLE,
            ),
            Expanded(
              child: Container(
                padding: controller.itemPadding,
                child: Row(
                  children: [
                    Expanded(child: GetBuilder<EbikeInfoController>(
                      id: 'brand',
                      builder: (_) =>Text(controller.brandValue == null? '请选择品牌': controller.brandValue,style: TextStyle(fontSize: 14,color: Colors.black87),),
                    )),
                    Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.grey[300],),
                  ],
                ),
              ),
              flex: EbikeInfoController.FLEX_CONTENT,
            ),
          ],
        ),
        splashColor: Colors.blue[50],
        focusColor: Colors.blue[50],
        highlightColor: Colors.blue[50],
        onTap: (){
          // Get.snackbar('', '品牌');
          controller.showChooseBrandDialog(context);
        },
      ),
    );
  }

  Widget _buildColor(){
    return Container(
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Text('颜色',style: TextStyle(fontSize: 14,color: Colors.black87),),
                    Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,)
                  ],
                ),
              ),flex: EbikeInfoController.FLEX_TITLE,
            ),
            Expanded(
              child: Container(
                padding: controller.itemPadding,
                child: Row(
                  children: [
                    Expanded(child: Text('请选择颜色',style: TextStyle(fontSize: 14,color: Colors.black87),)),
                    Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.grey[300],),
                  ],
                ),
              ),
              flex: EbikeInfoController.FLEX_CONTENT,
            ),
          ],
        ),
        splashColor: Colors.blue[50],
        focusColor: Colors.blue[50],
        highlightColor: Colors.blue[50],
        onTap: (){
          Get.snackbar('', '品牌');
        },
      ),
    );
  }

  Widget _buildBuyPrice(){
    return Container(
      padding: controller.itemPadding,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text('购买价格',style: TextStyle(fontSize: 14,color: Colors.black87),),
                  Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,)
                ],
              ),
            ),flex: EbikeInfoController.FLEX_TITLE,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: controller.buyPriceController,
                maxLines: 1,
                autocorrect: true,//是否自动更正
                // autofocus: true,//是否自动对焦
                textAlign: TextAlign.start,//文本对齐方式
                obscureText: false,//是否是密码
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                  hintText: '请输入购买时价格',
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
                  LogUtils.GGQ('price no onSubmitted:${text}');
                },
              ),
            ),
            flex: EbikeInfoController.FLEX_CONTENT,
          ),
        ],
      ),
    );
  }

  Widget _buildBuyDate(BuildContext context){
    return Container(
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Text('购买时间',style: TextStyle(fontSize: 14,color: Colors.black87),),
                    Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,)
                  ],
                ),
              ),flex: EbikeInfoController.FLEX_TITLE,
            ),
            Expanded(
              child: Container(
                padding: controller.itemPadding,
                child: Row(
                  children: [
                    Expanded(child: GetBuilder<EbikeInfoController>(
                      id: 'buyTime',
                      builder: (_) => Text(controller.dateValue == null ? '请选择购买时间':controller.dateValue,style: TextStyle(fontSize: 14,color: Colors.black87),),
                    )),
                    Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.grey[300],),
                  ],
                ),
              ),
              flex: EbikeInfoController.FLEX_CONTENT,
            ),
          ],
        ),
        splashColor: Colors.blue[50],
        focusColor: Colors.blue[50],
        highlightColor: Colors.blue[50],
        onTap: (){
          //Get.snackbar('', '购买时间');
          controller.showChooseBuyDateDialog(context);
        },
      ),
    );
  }

  Widget _buildSafeService(){
    return Container(
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Text('保障服务',style: TextStyle(fontSize: 14,color: Colors.black87),),
                    Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,)
                  ],
                ),
              ),flex: EbikeInfoController.FLEX_TITLE,
            ),
            Expanded(
              child: Container(
                padding: controller.itemPadding,
                child: Row(
                  children: [
                    Expanded(child: Text('请选择保障服务',style: TextStyle(fontSize: 14,color: Colors.black87),)),
                    Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.grey[300],),
                  ],
                ),
              ),
              flex: EbikeInfoController.FLEX_CONTENT,
            ),
          ],
        ),
        splashColor: Colors.blue[50],
        focusColor: Colors.blue[50],
        highlightColor: Colors.blue[50],
        onTap: (){
          Get.snackbar('', '保障服务');
        },
      ),
    );
  }

  Widget _buildSafeContent(){
    return Container(
      padding: controller.itemPadding,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('保障内容',style: TextStyle(fontSize: 14,color: Colors.black87),),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text('保障内容保障内容保障内容保障内容保障内容保障内容保障内容保障内容保障内容保障内容保障内容保障内容',style: TextStyle(fontSize: 13,color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildRemark(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Text('备注信息',style: TextStyle(fontSize: 14,color: Colors.black87),),
                Visibility(child: Image.asset(AssetsProvider.imagePath('ic_must'),width: 10,height: 10,),visible: false,),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: RemarkInput(
              hasShowLength: true,
              height: 92,
              placeholder: '备注',
              onChanged: (String txt){
                // inputText = txt;
              },
            ),
          )
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