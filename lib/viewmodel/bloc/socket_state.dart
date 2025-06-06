part of 'socket_bloc.dart';

class SocketState extends Equatable {
  final ResponseStatus status;
  final ResponseStatus statusMessages;
  final String? error;
  final List<Chat> chats;
  final List<Map<String, dynamic>>? messages;
  final String? chatId;
  final UserReport? chatUser;

  const SocketState({
    this.status = ResponseStatus.initial,
    this.statusMessages = ResponseStatus.initial,
    this.error,
    this.chats = const [],
    this.messages,
    this.chatId,
    this.chatUser,
  });

  SocketState copyWith({
    ResponseStatus? status,
    ResponseStatus? statusMessages,
    String? error,
    List<Chat>? chats,
    List<Map<String, dynamic>>? messages,
    String? chatId,
    UserReport? chatUser,
  }) {
    return SocketState(
      status: status ?? this.status,
      statusMessages: statusMessages ?? this.statusMessages,
      error: error ?? this.error,
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
      chatId: chatId ?? this.chatId,
      chatUser: chatUser ?? this.chatUser,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusMessages,
        error,
        chats,
        messages,
        chatId,
        chatUser,
      ];
}

// final class SocketInitial extends SocketState {}
