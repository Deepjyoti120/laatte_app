import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';
import 'package:stream_transform/stream_transform.dart';

part 'employee_event.dart';
part 'employee_state.dart';

int pageSize = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(const EmployeeState()) {
    on<EmployeeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<EmployeeFetch>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<EmployeeFresh>(
      _onEmployeeFresh,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPostFetched(
    EmployeeFetch event,
    Emitter<EmployeeState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ResponseStatus.initial) {
        final employees = await ApiService().employees(limit: pageSize);
        return emit(
          state.copyWith(
            status: ResponseStatus.success,
            posts: employees,
            hasReachedMax: employees.length < pageSize ? true : false,
          ),
        );
      }
      final employees =
          await ApiService().employees(page: state.page + 1, limit: pageSize);
      employees.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ResponseStatus.success,
                posts: List.of(state.employees)..addAll(employees),
                hasReachedMax: employees.length < pageSize ? true : false,
                page: state.page + 1,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ResponseStatus.failure));
    }
  }

  Future _onEmployeeFresh(
    EmployeeFresh event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      final employees = await ApiService().employees(limit: pageSize);
      return emit(
        state.copyWith(
          status: ResponseStatus.success,
          posts: employees,
          hasReachedMax: employees.length < pageSize ? true : false,
          page: 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ResponseStatus.failure));
    }
  }
}
