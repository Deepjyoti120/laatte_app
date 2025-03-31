import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/services/socket_services.dart';
import 'package:laatte/ui/theme/container.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/viewmodel/bloc/socket_bloc.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';

class ChatMessages extends StatefulWidget {
  static const String route = "/ChatMessages";
  const ChatMessages({super.key, required this.chatId});
  final String chatId;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  // final socketService = SocketService();
  final TextEditingController messageController = TextEditingController();
  // List<Map<String, dynamic>> messages = [];
  final FocusNode textFieldFocus = FocusNode();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    runInit();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  runInit() async {
    // messages = await ApiService().chat(widget.chatId);
    // setState(() {});
    // socketService.connect();
    // Future.delayed(const Duration(seconds: 1), () {
    //   socketService.joinChat(widget.chatId);
    // });
    // socketService.listenForMessages((message) {
    //   if (mounted) {
    //     if (message['chatId'] == widget.chatId) {
    //       setState(() {
    //         messages.add(message);
    //       });
    //     }
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //  context.read<SocketBloc>().add(SocketMessage(chatId: widget.chatId));
    });
  }

  void sendMessage() async {
    setState(() {
      isLoading = true;
    });
    if (messageController.text.isNotEmpty) {
      final userReportBloc = context.read<UserReportBloc>();
      final user = userReportBloc.state.userReport;

      if (user == null || user.id == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found!")),
        );
        return;
      }
      ApiService().chatSend(
        chatId: widget.chatId,
        message: messageController.text.trim(),
      );

      // socketService.sendMessage(
      //   widget.chatId,
      //   user.id!,
      //   messageController.text.trim(),
      // );
      messageController.clear();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    textFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserReportBloc>().state.userReport;
    final size = MediaQuery.sizeOf(context);
    final messages = context.watch<SocketBloc>().state.messages;
    return Scaffold(
      appBar: AppBar(title: const DesignText("Messages")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: () async {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: DesignColor.backgroundColorDarkMode,
            elevation: 0,
            label: SizedBox(
              width: size.width - 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 4),
                child: TextField(
                  controller: messageController,
                  focusNode: textFieldFocus,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    // fillColor: DesignColor.backgroundColorDarkMode,
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    hintText: 'Type...',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (messageController.text.isNotEmpty) {
                                sendMessage();
                              }
                            },
                      icon: Icon(
                        isLoading ? FontAwesomeIcons.stop : Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTapOutside: (event) {
                    final currentFocus = FocusScope.of(context);
                    if (currentFocus.focusedChild != null) {
                      currentFocus.focusedChild!.unfocus();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: messages?.length,
        reverse: true,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 120),
        itemBuilder: (context, index) {
          final data = messages?.reversed.toList()[index];
          bool isME = data?['senderId'] == user?.id;
          return Padding(
            padding: isME
                ? const EdgeInsets.fromLTRB(60, 12, 12, 6)
                : const EdgeInsets.fromLTRB(12, 12, 60, 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment:
                  isME ? MainAxisAlignment.end : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: DesignContainer(
                    color: isME
                        ? DesignColor.blue2
                        : DesignColor.backgroundColorDarkMode,
                    borderRadius: BorderRadius.only(
                      bottomLeft: isME
                          ? const Radius.circular(30)
                          : const Radius.circular(6),
                      bottomRight: const Radius.circular(30),
                      topLeft: const Radius.circular(30),
                      topRight: isME
                          ? const Radius.circular(6)
                          : const Radius.circular(30),
                    ),
                    isColor: true,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                      child: DesignText(
                        data?['message'] ?? "",
                        fontSize: 13,
                        fontWeight: 700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
