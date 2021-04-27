import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/pages/pay/pay_controller.dart';

class PayView extends GetView<PayController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white ,
        elevation: 0.0,
        title: Text('选择支付方式',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 10.h)),
          _buildPrice(),
          Padding(padding: EdgeInsets.only(top: 18.h,bottom: 10.h),child: Divider(
            height: .5,
            thickness: .5,
            color: Colors.grey[100],
          ),),
          _buildPay(),
          Padding(padding: EdgeInsets.symmetric(vertical: 10.h),child: Divider(
            height: .5,
            thickness: .5,
            color: Colors.grey[100],
          ),),
          _buildNext(),
        ],
      ),
    );
  }



  Widget _buildPrice(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('支付金额',style: TextStyle(fontSize: 14,color: Colors.black87),),
        RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.red),
              children: [
                TextSpan(
                  text: '100.00',
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.red),
                ),
                TextSpan(
                  text: '\t元',
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black87),
                ),
              ]
            ),
        ),
      ],
    );
  }

  Widget _buildPay(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('支付方式',style: TextStyle(fontSize: 14,color: Colors.black87),),
        OutlinedButton(onPressed: (){},
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14,color: Colors.black54))
          ),
          child: Row(
            children: [
              Text('扫码支付',style: TextStyle(fontSize: 14,color: Colors.black54),),
              Padding(padding: EdgeInsets.symmetric(horizontal: 2.w)),
              Icon(Icons.keyboard_arrow_down,size: 16,color: Colors.black54,)
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildNext(){
    return Container(
      margin: EdgeInsets.only(top: 30,bottom: 20),
      width: 0.72.sw,
      height: 48.h,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            side: BorderSide(width: 1, color: Colors.grey[200]),
          ),
          onPressed: (){
            //controller.onNext();
          },
          child: Text('去支付',style: TextStyle(color: Colors.black54,fontSize: 14),)
      ),
    );
  }

}