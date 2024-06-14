
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/services/log_service.dart';

class IntranetController extends GetxController{
  late WebViewController controller;
  double webProgress = 0;
  String? url;

  initialFunction(var widget){
    url = widget.url!;
    if (url != null && Uri.tryParse(url!) != null) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(url!));
    } else {
      LogService.i('Invalid or null URL');
    }
  }

  backToHomePage(){
    Get.back();
  }

}