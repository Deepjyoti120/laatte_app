import 'package:flutter/material.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/data/welcome_splash.dart';
import 'package:laatte/viewmodel/model/chat.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

class ChatScreen extends StatefulWidget {
  static const String route = "/ChatScreen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Chat> chats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    runInit();
  }

  void runInit() async {
    chats = await ApiService().chats();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: chats.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final chat = chats[index];
            return GestureDetector(
              onTap: () async {
                context
                    .push(Routes.chatMessages, extra: chat.id)
                    .then((e) async {
                  chats = await ApiService().chats();
                  isLoading = false;
                  setState(() {});
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Card(
                  color: DesignColor.backgroundColorDarkMode,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: DesignColor.yellow,
                              width: 2,
                            ),
                          ),
                          width: 54,
                          height: 54,
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              chat.user?.profilePicture ?? "",
                              alignment: Alignment.center,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        8.width,
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DesignText(
                                chat.user?.name ?? "",
                                fontSize: 16,
                                fontWeight: 500,
                                color: Colors.white,
                              ),
                              if (chat.lastMessage != null)
                                DesignText(
                                  chat.lastMessage?.content ?? '',
                                  fontSize: 14,
                                  fontWeight: 400,
                                  color: Colors.white,
                                  maxLines: 2,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
