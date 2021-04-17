import 'package:get/get.dart';

class HomeController extends GetxController{
  var _currentIndex = 0.obs;

  int get currentIndex{
    return _currentIndex.value;
  }

  void selectedItem(int index) {
    this._currentIndex.value = index;
  }


  @override
  void onInit() {
    super.onInit();
  }

}