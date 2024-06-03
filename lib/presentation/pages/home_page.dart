import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/services/log_service.dart';
import '../../core/services/utils_service.dart';
import '../../data/repositories/gemini_talk_repository_impl.dart';
import '../../domain/usecases/gemini_text_and_image_usecase.dart';
import '../../domain/usecases/gemini_text_only_usecase.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GeminiTextOnlyUseCase textOnlyUseCase =
  GeminiTextOnlyUseCase(GeminiTalkRepositoryImpl());
  GeminiTextAndImageUseCase textAndImageUseCase =
  GeminiTextAndImageUseCase(GeminiTalkRepositoryImpl());

  apiTextOnly() async {
    var text = "What is the best way to learn Flutter development?";
    var result = await textOnlyUseCase.call(text);
    LogService.d(result);
  }

  apiTextAndImage() async {
    var text = "What is this image?";
    var base64 = await Utils.pickAndConvertImage();

    var result = await textAndImageUseCase.call(text, base64);
    LogService.d(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image(image: AssetImage('assets/images/gemini_logo.png'),width: 100,),
      ),
      body: Container(

        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 1.5,
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                ),
              ),
              height: 50,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Expanded(
                      child:TextField(
                        style: TextStyle(color:Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                  ),

                  Row(
                    children: [
                      IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Colors.white,
                          )
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.keyboard_voice_sharp,
                            color: Colors.white,
                          )
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          )
                      ),
                    ],
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}