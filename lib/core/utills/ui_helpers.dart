import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:cine_flow/core/theme/app_colors.dart';

class UiHelpers {
  static void showError(String message) {
    if(Get.isSnackbarOpen) return ; 

    Get.snackbar(
      "Error",
       message,
       snackPosition: SnackPosition.BOTTOM, 
       margin: const EdgeInsets.all(10), 
       backgroundColor: AppColors.primary.withValues(alpha: 0.9), 
       colorText: AppColors.textPrimary , 
       borderRadius: 10 , 
        duration: const Duration(seconds: 3), 
        icon: Icon(Icons.error_outline, color: AppColors.textPrimary,)
       );
  } 

  static void showSuccess(String message) {
    if(Get.isSnackbarOpen) return ; 

    Get.snackbar(
      "Success",
       message,
       snackPosition: SnackPosition.BOTTOM, 
       margin: const EdgeInsets.all(10), 
       backgroundColor: Colors.green.withValues(alpha: 0.9), 
       colorText: AppColors.textPrimary , 
       borderRadius: 10 , 
        duration: const Duration(seconds: 3), 
        icon: Icon(Icons.check_circle_outline, color: AppColors.textPrimary,)
       );
  }

  
}