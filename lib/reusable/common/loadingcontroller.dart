import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Loadingcontroller extends GetxController{
  static Loadingcontroller get to => Get.find();
  final _isloading = false.obs;

  bool get isloading => _isloading.value;
  set isloading(bool value) => _isloading.value = value;
  void setIsloading(bool value) => _isloading.value = value;
}