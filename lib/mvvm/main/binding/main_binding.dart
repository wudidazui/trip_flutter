import 'package:get/get.dart';

import '../controllers/controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MainViewModel>(() => MainViewModel());
  }
}
