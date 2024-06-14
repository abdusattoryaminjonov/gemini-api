import 'package:flutter/material.dart';
import 'package:gemini_https/core/services/log_service.dart';
import 'package:gemini_https/presentation/controllers/intranet_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IntranetPage extends StatefulWidget {
  final String url;
  const IntranetPage({super.key,required this.url});

  @override
  State<IntranetPage> createState() => _IntranetPageState();
}

class _IntranetPageState extends State<IntranetPage> {
  final intranetController = Get.find<IntranetController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    intranetController.initialFunction(widget);
    LogService.i(widget.toString());

  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       centerTitle: true,
  //       backgroundColor: Colors.black,
  //       leading: GestureDetector(
  //         onTap: () {
  //           intranetController.backToHomePage();
  //         },
  //         child: Container(
  //           child: Icon(Icons.arrow_back ,color: Colors.grey,),
  //         ),
  //       ),
  //     ),
  //     body: WebViewWidget(
  //         controller: intranetController.controller
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntranetController>(
        builder: (_){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.black,
              leading: GestureDetector(
                onTap: () {
                  intranetController.backToHomePage();
                },
                child: Container(
                  child: Icon(Icons.arrow_back ,color: Colors.grey,),
                ),
              ),
            ),
            body: WebViewWidget(
                controller: intranetController.controller
            ),
          );
        }
    );
  }
}
