part of 'employee_bloc.dart';

class EmployeeState extends Equatable {
  const EmployeeState({
    this.status = ResponseStatus.initial,
    this.employees = const <UserReport>[],
    this.hasReachedMax = false,
    this.page = 1,
  });

  final ResponseStatus status;
  final List<UserReport> employees;
  final bool hasReachedMax;
  final int page;

  EmployeeState copyWith({
    ResponseStatus? status,
    List<UserReport>? posts,
    bool? hasReachedMax,
    int? page,
  }) {
    return EmployeeState(
      status: status ?? this.status,
      employees: posts ?? this.employees,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${employees.length} }''';
  }

  @override
  List<Object> get props => [status, employees, hasReachedMax, page];
}

// final class EmployeeInitial extends EmployeeState {}
