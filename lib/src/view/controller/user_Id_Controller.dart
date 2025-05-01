import 'package:get/get.dart';
class UserIdController extends GetxController {
  RxString uid = "".obs;

  void setUid(String value){
    uid.value = value;
  }
}