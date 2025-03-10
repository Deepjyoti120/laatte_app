import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/services/socket_services.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';

class ChatMessages extends StatefulWidget {
  static const String route = "/ChatMessages";
  const ChatMessages({super.key, required this.chatId});
  final String chatId;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final socketService = SocketService();
  final TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    runInit();
  }

  runInit() async {
    messages = await ApiService().chat(widget.chatId);
    setState(() {});
    socketService.connect();
    Future.delayed(const Duration(seconds: 1), () {
      socketService.joinChat(widget.chatId);
    });
    socketService.listenForMessages((message) {
      if (mounted) {
        if (message['chatId'] == widget.chatId) {
          setState(() {
            messages.add(message);
          });
        }
      }
    });
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      final userReportBloc = context.read<UserReportBloc>();
      final user = userReportBloc.state.userReport;

      if (user == null || user.id == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found!")),
        );
        return;
      }

      socketService.sendMessage(
        widget.chatId,
        user.id!,
        messageController.text.trim(),
      );
      messageController.clear();
    }
  }

  @override
  void dispose() {
    socketService.disconnect();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? const Center(child: Text("No messages yet"))
                : ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(messages[index]['message']),
                        subtitle:
                            Text("Sender: ${messages[index]['senderId']}"),
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
                    controller: messageController,
                    decoration:
                        const InputDecoration(hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
