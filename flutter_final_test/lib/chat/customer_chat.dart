import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/chat/feature_box.dart';
import 'package:flutter_final_test/chat/openai_service.dart';
import 'package:flutter_final_test/widgets/palette.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CustomerChat extends StatefulWidget {
  const CustomerChat({super.key});

  @override
  State<CustomerChat> createState() => _CustomerChatState();
}

class _CustomerChatState extends State<CustomerChat> {
  final speechtoText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;
  final OpenAiService openAiService = OpenAiService();
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    
  }



  Future<void> initSpeechToText() async {
    await speechtoText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await speechtoText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  Future<void> _stopListening() async {
    await speechtoText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  

  @override
  void dispose() {
    super.dispose();
    speechtoText.stop();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chăm sóc khách hàng"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/virtualAssistant.png'))),
                )
              ],
            ),
            Visibility(
               visible: generatedImageUrl == null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Pallete.borderColor),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    )),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Xin chào, tôi có thể giúp gì cho bạn !",
                    style: TextStyle(
                      color: Pallete.mainFontColor,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, left: 22),
              child: Text(
                'Đây là một vài chức năng bạn có thể dùng để hỏi ',
                style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 13,
                ),
              ),
            ),
            const Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'ChatGPT',
                  descriptionText: "Thuận lợi hơn cho việc hỏi đáp và tìm hiểu",
                ),
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'Chat with shop',
                  descriptionText:
                      "Trực tiếp tư vấn cho khách hàng và giải quyết sớm nhất",
                ),
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'Trợ lý voice ảo',
                  descriptionText: "Vấn đáp với trợ lý sử dụng voice thông minh",
                ),
              ],
            ),
            FloatingActionButton(
              backgroundColor: Pallete.firstSuggestionBoxColor,
              onPressed: () async {
                if (await speechtoText.hasPermission &&
                    speechtoText.isNotListening) {
                  await _startListening();
                } else if (speechtoText.isListening) {
                  await openAiService.isArtPromptAPI(lastWords);
                  await _stopListening();
                } else {
                  initSpeechToText();
                }
              },
              child: Icon(Icons.mic),
            )
          ],
        ),
      ),
    );
  }
}
