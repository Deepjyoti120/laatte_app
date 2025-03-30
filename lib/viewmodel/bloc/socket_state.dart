part of 'socket_bloc.dart';

class SocketState extends Equatable {
  final ResponseStatus status;
  final String? error;
  final List<Chat> chats;
  const SocketState({
    this.status = ResponseStatus.initial,
    this.error,
    this.chats = const [],
  });

  SocketState copyWith({
    ResponseStatus? status,
    String? error,
    List<Chat>? chats,
  }) {
    return SocketState(
      status: status ?? this.status,
      error: error ?? this.error,
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        chats,
      ];
}

// final class SocketInitial extends SocketState {}
