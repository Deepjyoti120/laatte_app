import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/viewmodel/model/prompt.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../services/api_services.dart';
part 'my_prompts_event.dart';
part 'my_prompts_state.dart';


int pageSize = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MyPromptsBloc extends Bloc<MyPromptsEvent, MyPromptsState> {
  MyPromptsBloc() : super(const MyPromptsState()) {
    // on<MyPromptsEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<MyPromptsFetched>(
      _onMyPromptsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }
   Future<void> _onMyPromptsFetched(
    MyPromptsFetched event,
    Emitter<MyPromptsState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ResponseStatus.initial) {
        final prompts = await ApiService().getMyPrompts(limit: pageSize);
        return emit(
          state.copyWith(
            status: ResponseStatus.success,
            prompts: prompts,
            hasReachedMax: prompts.length < pageSize ? true : false,
          ),
        );
      }
      final prompts =
          await ApiService().getMyPrompts(page: state.page + 1, limit: pageSize);
      prompts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ResponseStatus.success,
                prompts: List.of(state.prompts)..addAll(prompts),
                hasReachedMax: prompts.length < pageSize ? true : false,
                page: state.page + 1,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ResponseStatus.failure));
    }
  }
}
