import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_app/common/utils/index.dart';

class PermissionDialog {

  static show(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('权限申请',style: TextStyle(fontSize: 14,color: Colors.black87),),
            content: Padding(
              child: Text('您需要授权使用相机权限？',style: TextStyle(color: Colors.black87,fontSize: 12),),
              padding: EdgeInsets.only(top: 10),
            ),
            actions: <Widget>[
              CupertinoDialogAction(child: Text('不同意',style: TextStyle(color: Colors.grey,fontSize: 14),),onPressed: (){
                  Navigator.of(context).pop('cancel');
              },),
              CupertinoDialogAction(child: Text('去设置',style: TextStyle(color: Colors.blue,fontSize: 14),),onPressed: (){
                Navigator.of(context).pop('ok');
                openSetting();
              },),
            ],
          );
        }
    );
  }


  static Future<bool> openSetting() async{
    return await openAppSettings();
  }
}