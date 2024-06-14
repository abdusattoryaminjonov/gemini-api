import 'package:flutter/material.dart';
import 'package:gemini_https/core/constants/constants.dart';
import 'package:gemini_https/presentation/controllers/starter_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

import 'home_page.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {

  final starterController = Get.find<StarterController>();

  @override
  void initState() {
    super.initState();
    starterController.speakTTS(welcomingMessage);
    starterController.initVideoPlayer();
  }

  @override
  void dispose() {
    starterController.videoPlayerController.dispose();
    starterController.stopTTS();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              Container(
                width: 120,
                child: Lottie.asset('assets/lotties/gemini_log.json'),

              ),
              Expanded(
                child: starterController.videoPlayerController.value.isInitialized
                    ? VideoPlayer(starterController.videoPlayerController)
                    : Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, HomePage.id);
                      // Navigator.push(context, PageTransition(
                      //   type: PageTransitionType.fade,
                      //     child: HomePage())
                      // );
                    },
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Chat with Gemini ',
                            style: TextStyle(color: Colors.grey[400], fontSize: 18),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}