part of 'socket_bloc.dart';

sealed class SocketEvent extends Equatable {
  const SocketEvent();

  @override
  List<Object> get props => [];
}

class SocketFetched extends SocketEvent {
  final Map<String, dynamic>? event;
  final UserReport? user;
  const SocketFetched({
    this.event,
    this.user,
  });
}

class SocketMessage extends SocketEvent {
  final String? chatId;
  final bool setChatID;
  final Map<String, dynamic>? event;
  final UserReport? chatUser;
  const SocketMessage({
    this.chatId,
    this.event,
    this.setChatID = false,
    this.chatUser,
  });
}

class SocketReset extends SocketEvent {}
