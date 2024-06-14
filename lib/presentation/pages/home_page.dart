import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';

import '../../core/services/utils_service.dart';
import '../controllers/home_controller.dart';
import '../widgets/item_gemini_message.dart';
import '../widgets/item_user_message.dart';


class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();


  @override
  void initState() {
    super.initState();
    homeController.initSTT();
    homeController.uploadData();

    ShakeDetector.autoStart(
        onPhoneShake: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Shake!'),
            ),
          );
        },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  void dispose() {
    homeController.textController.dispose();
    homeController.textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<HomeController>(
          builder: (_){
            return Container(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 45,
                    child: Image(
                      image: AssetImage('assets/images/gemini_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: homeController.messages.isEmpty
                          ? Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child:
                          Image.asset('assets/images/gemini_icon.png'),
                        ),
                      )
                          : ListView.builder(
                        itemCount: homeController.messages.length,
                        itemBuilder: (context, index) {
                          var message = homeController.messages[index];
                          if (message.isMine!) {
                            return itemOfUserMessage(message);
                          } else {
                            return itemOfGeminiMessage(message,homeController,context);
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        homeController.pickedImage == null
                            ? const SizedBox.shrink()
                            : Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              Utils.base64Decode(
                                homeController.pickedImage!
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: homeController.textController,
                                maxLines: null,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Message',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                homeController.onSelectedImage();
                              },
                              icon: const Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            // if (homeController.textController.text
                            //     .isEmpty) // Show icons only if text is empty
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                homeController.speechToText.isNotListening
                                    ? homeController.startSTT()
                                    : homeController.stopSTT();
                              },
                              icon: const Icon(
                                Icons.mic,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                var text = homeController.textController.text
                                    .toString()
                                    .trim();
                                homeController.onSendPressed(text);
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ),
    );
  }
}