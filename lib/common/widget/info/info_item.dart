import 'package:flutter/material.dart';
import 'package:getx_app/common/utils/index.dart';

class InfoItem extends StatelessWidget {

  final String title;
  final String content;
  final bool hasNote;

  InfoItem({@required this.title,@required this.content,this.hasNote = true}):super();

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        children: [
          Text(this.title,style: _titleStyle(),),
          Visibility(child: Icon(Iconfont.redDot,size: 4,color: Colors.red,),),
          Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
          Text(this.content,style: _contentStyle(),),
        ],
      ),
    );
  }

  TextStyle _titleStyle(){
    return TextStyle(fontSize: 14,color: Colors.black87);
  }

  TextStyle _contentStyle(){
    return TextStyle(fontSize: 14,color: Colors.black54);
  }
}
