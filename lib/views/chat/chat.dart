import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/viewmodel/bloc/socket_bloc.dart';

class ChatScreen extends StatefulWidget {
  static const String route = "/ChatScreen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List<Chat> chats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    runInit();
  }

  void runInit() async {
    // chats = await ApiService().chats();
    // isLoading = false;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final chats = context.watch<SocketBloc>().state.chats;
    return Scaffold(
      // appBar: AppBar(
      //   title: const DesignText(
      //     "Chats",
      //     fontSize: 20,
      //     fontWeight: 600,
      //   ),
      //   elevation: 0,
      // ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
              child: Image.asset(
                AssetsName.pngBg,
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, Utils.isIOS ? 90 : 80),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.height,
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: DesignText(
                        "Chats",
                        fontSize: 20,
                        fontWeight: 600,
                      ),
                    ),
                    8.height,
                    ListView.builder(
                      itemCount: chats.length,
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        return GestureDetector(
                          onTap: () async {
                            context.read<SocketBloc>().add(SocketMessage(
                                chatId: chat.id, setChatID: true));
                            context
                                .push(Routes.chatMessages, extra: chat.id)
                                .then((e) {
                              if (!mounted) return;
                              // context
                              //     .read<SocketBloc>()
                              //     .add(const SocketMessage(setChatID: true,chatId: null));
                              // chats = await ApiService().chats();
                              // setState(() {});
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
