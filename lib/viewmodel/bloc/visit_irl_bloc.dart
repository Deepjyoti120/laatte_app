import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/viewmodel/model/visit_irl.dart';
import 'package:stream_transform/stream_transform.dart';
part 'visit_irl_event.dart';
part 'visit_irl_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class VisitIrlBloc extends Bloc<VisitIrlEvent, VisitIrlState> {
  VisitIrlBloc() : super(const VisitIrlState()) {
    on<VisitIrlEvent>((event, emit) {});
    on<VisitIrlFetch>(
      _onVisitIrlFetch,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onVisitIrlFetch(
    VisitIrlFetch event,
    Emitter<VisitIrlState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ResponseStatus.loading));
      final visitIrls = await ApiService().visitIrls(event.context);
      emit(state.copyWith(
        visitIrls: visitIrls,
        status: ResponseStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ResponseStatus.failure,
        visitIrls: [],
      ));
    }
  }
}
