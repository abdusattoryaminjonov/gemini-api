import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'home_page.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
    VideoPlayerController.asset("assets/videos/gemini_video.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Container(
                child: Image(
                  width: 150,
                  image: AssetImage('assets/images/gemini_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: videoPlayerController.value.isInitialized
                    ? VideoPlayer(videoPlayerController)
                    : Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromRGBO(255, 255, 255, 1.0),
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, HomePage.id);
                      },
                      child: Row(

                          children: [
                            Text('Chat with Gemini', style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),),
                            SizedBox(width: 10,),
                            Icon(Icons.navigate_next_outlined,color: Colors.white,),
                          ]
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}