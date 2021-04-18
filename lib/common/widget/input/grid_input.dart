import 'package:flutter/material.dart';
import 'package:getx_app/common/utils/index.dart';

class GridInput extends StatefulWidget {
  @override
  _GridInputState createState() => _GridInputState();
}

class _GridInputState extends State<GridInput> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 0.82.sw,
        child: Container(
            child: TextField(
          maxLines: 1,
          autocorrect: true,
          //是否自动更正
          autofocus: true,
          //是否自动对焦
          textAlign: TextAlign.center,
          //文本对齐方式
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            isDense: true,
            counterText: '',
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (text) {
            //内容改变的回调
            if (text.isNotEmpty) {
              selectedIndex(3);
            }
          },
          onSubmitted: (text) {
            //内容提交(按回车)的回调
          },
        )),
      ),
    );
  }

  void selectedIndex(int index) {
    LogUtils.GGQ('index->${index}');
  }
}
