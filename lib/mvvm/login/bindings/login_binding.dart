import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/login/controllers/login_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
  }
}
