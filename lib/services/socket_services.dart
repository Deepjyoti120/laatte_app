import 'package:laatte/common_libs.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  io.Socket? socket;
  bool isConnected = false;

  void connect() {
    if (isConnected) return; // Don't connect twice

    socket = io.io(Constants.apiUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 2000,
    });

    socket?.on('connect', (_) {
      isConnected = true;
      print("✅ Socket connected!");
    });

    socket?.on('disconnect', (_) {
      isConnected = false;
      print("❌ Socket disconnected!");
    });
  }

  void joinChat(String chatId) {
    if (isConnected) {
      print('✅ Joined chat: $chatId');
      socket?.emit('join', {'chatId': chatId});
    }
  }

  void sendMessage(String chatId, String senderId, String message) {
    if (isConnected) {
      print('📤 Emitting message: $message');
      socket?.emit('sendMessage', {
        'chatId': chatId,
        'senderId': senderId,
        'message': message,
      });
    } else {
      print("⚠️ Can't send message. Not connected!");
    }
  }

  void listenForMessages(Function(Map<String, dynamic>) callback) {
    socket?.on('newMessage', (data) {
      print('📩 Received message: $data');
      callback(Map<String, dynamic>.from(data));
    });
  }

  void disconnect() {
    socket?.disconnect();
    isConnected = false;
  }
}
