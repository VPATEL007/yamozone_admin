import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamazone/controller/my_controller.dart';
import 'package:yamazone/models/customer.dart';

class CustomersController extends MyController {
  List<Customer> customers = [];
  DataTableSource? data;

  CustomersController();

  int currentPage = 1;

  @override
  void onInit() {
    super.onInit();

    Customer.dummyList.then((value) {
      customers = value;

      update();
    });
  }

  void goToDashboard() {
    Get.toNamed('/dashboard');
  }
}
