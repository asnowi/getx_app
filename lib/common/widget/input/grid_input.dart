import 'package:flutter/material.dart';
import 'package:getx_app/common/utils/index.dart';

class GridInput extends StatefulWidget {
  @override
  _GridInputState createState() => _GridInputState();
}

class _GridInputState extends State<GridInput> {

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  final List<bool> focusList = [
    true,
    false,
    false,
    false,
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.82.sw,
      child: Row(
      children: [
        Expanded(
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    color: Colors.grey[300],
                    width: 1,
                    style: BorderStyle.solid
                ))
            ),
            child: Center(
                child: Container(
                    child: TextField(
                      controller: controller1,
                      maxLines: 1,
                      autocorrect: true,//是否自动更正
                      autofocus: focusList[0],//是否自动对焦
                      textAlign: TextAlign.center,//文本对齐方式
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        counterText: '',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (text) {//内容改变的回调
                        if(text.isNotEmpty){
                          selectedIndex(1);
                        }
                      },
                      onSubmitted: (text) {//内容提交(按回车)的回调

                      },
                    )
                )
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
        Expanded(
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    color: Colors.grey[300],
                    width: 1,
                    style: BorderStyle.solid
                ))
            ),
            child: Center(
                child: Container(
                    child: TextField(
                      controller: controller2,
                      maxLines: 1,
                      autocorrect: true,//是否自动更正
                      autofocus: focusList[1],//是否自动对焦
                      textAlign: TextAlign.center,//文本对齐方式
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        counterText: '',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (text) {//内容改变的回调
                        if(text.isNotEmpty){
                          selectedIndex(2);
                        }
                      },
                      onSubmitted: (text) {//内容提交(按回车)的回调

                      },
                    )
                )
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
        Expanded(
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    color: Colors.grey[300],
                    width: 1,
                    style: BorderStyle.solid
                ))
            ),
            child: Center(
                child: Container(
                    child: TextField(
                      controller: controller3,
                      maxLines: 1,
                      autocorrect: true,//是否自动更正
                      autofocus: focusList[2],//是否自动对焦
                      textAlign: TextAlign.center,//文本对齐方式
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        counterText: '',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (text) {//内容改变的回调
                        if(text.isNotEmpty){
                          selectedIndex(3);
                        }
                      },
                      onSubmitted: (text) {//内容提交(按回车)的回调

                      },
                    )
                )
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
        Expanded(
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    color: Colors.grey[300],
                    width: 1,
                    style: BorderStyle.solid
                ))
            ),
            child: Center(
                child: Container(
                    child: TextField(
                      controller: controller4,
                      maxLines: 1,
                      autocorrect: true,//是否自动更正
                      autofocus: focusList[3],//是否自动对焦
                      textAlign: TextAlign.center,//文本对齐方式
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        counterText: '',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (text) {//内容改变的回调
                        if(text.isNotEmpty){
                          selectedIndex(4);
                        }
                      },
                      onSubmitted: (text) {//内容提交(按回车)的回调

                      },
                    )
                )
            ),
          ),
        ),
      ],
    ));
  }


  void selectedIndex(int index){
    focusList.forEach((element) {
      element = false;
      focusList[index] = true;
    });
  }
}
