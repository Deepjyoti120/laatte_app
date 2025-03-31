part of 'socket_bloc.dart';

class SocketState extends Equatable {
  final ResponseStatus status;
  final ResponseStatus statusMessages;
  final String? error;
  final List<Chat> chats;
  final List<Map<String, dynamic>>? messages;
  final String? chatId;
  const SocketState({
    this.status = ResponseStatus.initial,
    this.statusMessages = ResponseStatus.initial,
    this.error,
    this.chats = const [],
    this.messages,
    this.chatId
  });

  SocketState copyWith({
    ResponseStatus? status,
    ResponseStatus? statusMessages,
    String? error,
    List<Chat>? chats,
    List<Map<String, dynamic>>? messages,
    String? chatId
  }) {
    return SocketState(
      status: status ?? this.status,
      statusMessages: statusMessages ?? this.statusMessages,
      error: error ?? this.error,
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
      chatId: chatId ?? this.chatId
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusMessages,
        error,
        chats,
        messages,
        chatId
      ];
}

// final class SocketInitial extends SocketState {}
