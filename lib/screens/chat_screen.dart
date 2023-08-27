import 'package:flutter/material.dart';

import '../models/app_color.dart';
import '../models/app_logic/calory_intake.dart';
import '../models/app_theme.dart';
import '../widgets/signing_widgets/wave_clipper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  void sendMessage(String message) {
    setState(() {
      messages.add(message);
      _textEditingController.clear();
      // Call the bot function to generate a response
      waitingForBotResponse(message);
    });
  }

  Future<void> waitingForBotResponse(String message) async {
    String response = await botResponse(message);
    setState(() {
      messages.add(response);
    });
  }

  Future<String> botResponse(String message) {
    // Replace this with your bot logic to generate a response based on the user's message
    return getFoodInfo(message);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryStartColor, primaryEndColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                centerTitle: true,
                title: const Text(
                  'المساعد الذكي',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppTheme.white,
                    fontFamily: AppTheme.fontName,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = index % 2 == 0;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MessageBubble(
                    text: message,
                    isUserMessage: isUserMessage,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    onSubmitted: sendMessage,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Send the message when the button is pressed
                    String message = _textEditingController.text.trim();
                    if (message.isNotEmpty) {
                      sendMessage(message);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                  ),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.isUserMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUserMessage ? AppTheme.greenSoft : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            color: isUserMessage ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
