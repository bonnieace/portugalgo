import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';


/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
/// 
/*
class NetworkManager extends GetxController {

  static NetworkManager get instance => Get.find();

 final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      TLoaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  /// Check the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream.
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
*/

class TLoaders {
  static warningSnackBar({required title,message=''}){
    Get.snackbar(title,
     message,
     isDismissible: true,
     shouldIconPulse: true,
     colorText: TColors.white,
     backgroundColor: Colors.orange,
     snackPosition: SnackPosition.BOTTOM,
     duration: Duration(seconds: 3),
     margin: EdgeInsets.all(20),
     icon: Icon(Iconsax.warning_2,color: TColors.white,)
     );
  }
    static errorSnackBar({required title,message=''}){
    Get.snackbar(title,
     message,
     isDismissible: true,
     shouldIconPulse: true,
     colorText: TColors.white,
     backgroundColor: Colors.red.shade600,
     snackPosition: SnackPosition.BOTTOM,
     duration: Duration(seconds: 3),
     margin: EdgeInsets.all(20),
     icon: Icon(Iconsax.warning_2,color: TColors.white,)
     );
  }
    static successSnackBar({required title,message='',duration=3}){
    Get.snackbar(title,
     message,
     isDismissible: true,
     shouldIconPulse: true,
     colorText: TColors.white,
     backgroundColor: Colors.orange,
     snackPosition: SnackPosition.BOTTOM,
     duration: Duration(seconds: duration),
     margin: EdgeInsets.all(20),
     icon: Icon(Iconsax.warning_2,color: TColors.white,)
     );
  }
}
