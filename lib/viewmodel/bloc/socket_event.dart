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
