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
      debugPrint("✅ Socket connected!");
    });

    socket?.on('disconnect', (_) {
      isConnected = false;
      debugPrint("❌ Socket disconnected!");
    });
  }

  void joinChat(String chatId) {
    if (isConnected) {
      debugPrint('✅ Joined chat: $chatId');
      socket?.emit('join', {'chatId': chatId});
    }
  }

  void sendMessage(String chatId, String senderId, String message) {
    if (isConnected) {
      debugPrint('📤 Emitting message: $message');
      socket?.emit('sendMessage', {
        'chatId': chatId,
        'senderId': senderId,
        'message': message,
      });
    } else {
      debugPrint("⚠️ Can't send message. Not connected!");
    }
  }

  void listenForMessages(Function(Map<String, dynamic>) callback) {
    // socket?.on('message', (data) {
    //   debugPrint('📩 Received message: $data');
    //   callback(Map<String, dynamic>.from(data));
    // });
    socket?.onAny((event, data) {
      debugPrint('🔥 Event: $event, Data: $data');
      final finalData = {
        'event': event,
        'data': data,
      };
      callback(Map<String, dynamic>.from(finalData));
    });
  }

  void disconnect() {
    socket?.disconnect();
    isConnected = false;
  }
}
