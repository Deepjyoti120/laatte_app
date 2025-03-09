import 'package:flutter/material.dart';
import 'package:laatte/viewmodel/model/chat.dart';

class ChatScreen extends StatefulWidget {
  static const String route = "/ChatScreen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  List<Chat> chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
