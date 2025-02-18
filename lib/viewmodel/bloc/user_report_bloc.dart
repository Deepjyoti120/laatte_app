import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/utils/constants.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';
import 'package:stream_transform/stream_transform.dart';
part 'user_report_event.dart';
part 'user_report_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UserReportBloc extends Bloc<UserReportEvent, UserReportState> {
  late final StreamSubscription<UserReport?> _subscription;
  UserReportBloc() : super(const UserReportState()) {
    // _subscription = SupaServices.userReport.listen((event) {
    //   add(UserReportFetched(event));
    // });
    // on<UserReportEvent>(
    //   (event, emit) {
    //     if (state.status != ResponseStatus.success) {
    //       emit(state.copyWith(status: ResponseStatus.loading));
    //     }
    //     if (event is UserReportFetched) {
    //       emit(state.copyWith(
    //         userReport: event.userReport,
    //         status: ResponseStatus.success,
    //       ));
    //     }
    //   },
    //   transformer: throttleDroppable(throttleDuration),
    // );
    on<UserReportFetched>(
      _onUserReportFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<UserReportStorage>(
      _onUserReportStorage,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onUserReportFetched(
    UserReportFetched event,
    Emitter<UserReportState> emit,
  ) async {
    try {
      if (kDebugMode) {
        print('event: $event');
      }
      final box = await Hive.openBox<UserReport>(Constants.profileBox);
      // if (state.status == ResponseStatus.initial) {
      emit(state.copyWith(status: ResponseStatus.loading));
      final data = await ApiService().profile;
      if (data != null) {
        await box.put(Constants.profileKey, data);
      }
      return emit(
        state.copyWith(
          status: ResponseStatus.success,
          userReport: data,
        ),
      );
      // }
    } catch (_) {
      emit(state.copyWith(status: ResponseStatus.failure));
    }
  }

  Future<void> _onUserReportStorage(
    UserReportStorage event,
    Emitter<UserReportState> emit,
  ) async {
    try {
      final box = await Hive.openBox<UserReport>(Constants.profileBox);
      final data = box.get(Constants.profileKey);
      return emit(
        state.copyWith(
          status: ResponseStatus.success,
          userReport: data,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ResponseStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
