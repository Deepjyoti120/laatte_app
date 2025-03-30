import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/services/socket_services.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/viewmodel/model/chat.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';
import 'package:stream_transform/stream_transform.dart';
part 'socket_event.dart';
part 'socket_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

// EventTransformer<E> throttleDroppable<E>(Duration duration) {
//   return (events, mapper) {
//     return events
//         .throttle(duration)
//         .transform(droppable() as StreamTransformer<E, dynamic>)
//         .asyncExpand(mapper as Stream<E>? Function(dynamic event));
//   };
// }

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  final socketService = SocketService();
  final BuildContext context;
  SocketBloc(this.context) : super(const SocketState()) {
    Future.microtask(() async {
      socketService.connect();
      socketService.listenForMessages((event) {
        final user = context.read<UserReportBloc>();
        add(SocketFetched(event: event, user: user.state.userReport));
      });
    });
    // on<SocketEvent>((event, emit) {
    // });
    on<SocketFetched>(
      _onSocketFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  Future<void> _onSocketFetched(
    SocketFetched event,
    Emitter<SocketState> emit,
  ) async {
    try {
      if (state.status == ResponseStatus.initial) {
        emit(state.copyWith(status: ResponseStatus.loading));
        final chats = await ApiService().chats();
        // if (chats.isEmpty) {
        return emit(
          state.copyWith(
            status: ResponseStatus.success,
            chats: chats,
          ),
        );
        // }
      }
      if (event.event == null || event.user == null) return;
      debugPrint(event.event?['event']);
      final eventKey = event.event?['event']?.toString();
      if ((eventKey?.contains("people") ?? false) ||
          event.event?['data'] != null ||
          (eventKey?.contains(event.user?.id ?? '') ?? false)) {
        // triger people chat api
        final chats = await ApiService().chats();
        return emit(
          state.copyWith(
            status: ResponseStatus.success,
            chats: chats,
          ),
        );
      }
      // end people chat api call
      //
    } catch (_) {
      emit(state.copyWith(status: ResponseStatus.failure));
    }
  }

  @override
  Future<void> close() {
    socketService.disconnect();
    return super.close();
  }
}
