import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/widget/scan/index.dart';
import 'package:getx_app/global.dart';
import 'package:flutter/foundation.dart';
import 'package:getx_app/common/utils/index.dart';
class ScannerView extends StatefulWidget{

  @override
  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  bool isHight = false;

  bool isFirst = false;


  @override
  void initState() {
    LogUtils.GGQ('initState');
    isFirst = false;
    super.initState();
  }
  @override
  void reassemble() async{
    LogUtils.GGQ('reassemble');
    super.reassemble();
    if(Global.isAndroid){
      controller.pauseCamera();
    }else if(Global.isIOS){
      controller.resumeCamera();
    }
    isHight = await controller.getFlashStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: _buildHandleView(),
          )
        ],
      ),
    );
  }

  // Widget _buildHandleView(){
  //   return FittedBox(
  //     fit: BoxFit.contain,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         if (result != null)
  //           Text(
  //               'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
  //         else
  //           Text('Scan a code'),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.all(8),
  //               child: ElevatedButton(
  //                   onPressed: () async {
  //                     await controller?.toggleFlash();
  //                     setState(() {});
  //                   },
  //                   child: FutureBuilder(
  //                     future: controller?.getFlashStatus(),
  //                     builder: (context, snapshot) {
  //                       return Text('Flash: ${snapshot.data}');
  //                     },
  //                   )),
  //             ),
  //             Container(
  //               margin: EdgeInsets.all(8),
  //               child: ElevatedButton(
  //                   onPressed: () async {
  //                     await controller?.flipCamera();
  //                     setState(() {});
  //                   },
  //                   child: FutureBuilder(
  //                     future: controller?.getCameraInfo(),
  //                     builder: (context, snapshot) {
  //                       if (snapshot.data != null) {
  //                         return Text(
  //                             'Camera facing ${describeEnum(snapshot.data)}');
  //                       } else {
  //                         return Text('loading');
  //                       }
  //                     },
  //                   )),
  //             )
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.all(8),
  //               child: ElevatedButton(
  //                 onPressed: () async {
  //                   await controller?.pauseCamera();
  //                 },
  //                 child: Text('pause', style: TextStyle(fontSize: 20)),
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.all(8),
  //               child: ElevatedButton(
  //                 onPressed: () async {
  //                   await controller?.resumeCamera();
  //                 },
  //                 child: Text('resume', style: TextStyle(fontSize: 20)),
  //               ),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildHandleView(){
    // return FittedBox(
    //   fit: BoxFit.contain,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //         IconButton(icon: Icon(Iconfont.scan,size: 20.w,), onPressed: (){}),
    //         IconButton(icon: Icon(Iconfont.scan), onPressed: (){}),
    //     ],
    //   ),
    // );




    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(icon: Icon(Iconfont.backOut,color: Colors.grey,), onPressed: (){
            Get.back();
          }),
          IconButton(icon: isHight? Icon(Icons.wb_sunny,color: Colors.white,): Icon(Icons.wb_sunny_outlined,color: Colors.grey,), onPressed: (){
            setState(() async{
              isHight = !isHight;
              await controller.toggleFlash();
            });
          }),
        ],
      ),
    );
  }


  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    // var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    var scanArea = 0.78.sw;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 3,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // setState(() {
      //   result = scanData;
      // });
      result = scanData;
      if(result != null){
        // LogUtils.GGQ('---format-->${describeEnum(result.format)}');
        if(!result.code.isBlank && !isFirst){
          // isFirst 过滤 返回多次的情况
          isFirst = true;
          LogUtils.GGQ('---code-->${result.code}');
          Get.back(result: result.code);
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
