class AssetsProvider{

  ///本地图片路径
  static String imagePath(String name,{String type = 'png'}){
    return 'assets/images/$name.$type';
  }

  ///本地json动画
  static String lottiePath(String name){
    return 'assets/json/$name.json';
  }

  /// 本地json 数据
  static String loadJson(String name){
    return 'assets/data/$name.json';
  }
}
