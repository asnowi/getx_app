import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_app/common/utils/index.dart';

typedef OnChanged = void Function(String txt);


class RemarkInput extends StatefulWidget {

  const RemarkInput({
    this.placeholder='请输入',
    this.onChanged,
    this.maxLength = 52,
    this.maxLines = 5,
    @required this.height,
    this.hasShowLength = false,
  });

  final String placeholder;
  final OnChanged onChanged;
  final int maxLength;
  final int maxLines;
  final double height;
  final bool hasShowLength;

  @override
  _RemarkInputState createState() => _RemarkInputState();
}

class _RemarkInputState extends State<RemarkInput> {

  String result = '';


  @override
  Widget build(BuildContext context) {
    return _buildTextInput();
  }

  Widget _buildTextInput(){
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          height: ScreenUtil().setHeight(widget.height),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
            border: Border.all(color: Color(0xFFDEDEDE)),
          ),
          alignment: AlignmentDirectional.topStart,
          margin: EdgeInsets.only(bottom: 10),
          child: CupertinoTextField(
            placeholder: widget.placeholder,
            style: TextStyle(fontSize: 14, color: Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            textInputAction: TextInputAction.unspecified,
            onChanged: (str) {
              setState(() {
                result = str;
                if(widget.onChanged != null){
                  widget.onChanged(str);
                }
              });
            },
          ),
        ),
        Visibility(child: Container(
          margin: EdgeInsets.only(bottom: 25, right: 20),
          child: Text(
            result.length.toString() + '/'+widget.maxLength.toString(),
            style: TextStyle(color: Colors.grey),
          ),
        ),visible: this.widget.hasShowLength,)
      ],
    );
  }
}
