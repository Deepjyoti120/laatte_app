import 'package:laatte/common_libs.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  late IO.Socket socket;

  SocketService._internal() {
    _connect();
  }

  void _connect() {
    socket = IO.io(Constants.apiUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to WebSocket server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from server');
    });
  }

  void joinChat(String chatId) {
    socket.emit('joinChat', chatId);
  }

  void sendMessage(String chatId, String senderId, String message) {
    socket.emit('sendMessage', {
      'chatId': chatId,
      'senderId': senderId,
      'message': message,
    });
  }

  void listenForMessages(Function(Map<String, dynamic>) onMessageReceived) {
    socket.on('newMessage', (data) {
      onMessageReceived(data);
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
