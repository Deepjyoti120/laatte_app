part of 'user_report_bloc.dart';

class UserReportState extends Equatable {
  final ResponseStatus status;
  final UserReport? userReport;
  final String? error;
  const UserReportState({
    this.status = ResponseStatus.initial,
    this.userReport,
    this.error,
  });
  // const UserReportState.initial() : this(status: UserReportStatus.initial);
  // const UserReportState.loading() : this(status: UserReportStatus.loading);
  // const UserReportState.loaded({
  //   required UserReport userReport,
  // }) : this(status: UserReportStatus.loaded, userReport: userReport);
  // const UserReportState.error({required String error})
  //     : this(
  //         status: UserReportStatus.error,
  //         error: error,
  //       );
  UserReportState copyWith({
    ResponseStatus? status,
    UserReport? userReport,
    String? error,
  }) {
    return UserReportState(
      status: status ?? this.status,
      userReport: userReport ?? this.userReport,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        userReport,
        status,
        error,
      ];
}

// abstract class UserReportState extends Equatable {
//   const UserReportState();
//   @override
//   List<Object> get props => [];
// }

// class UserReportInitial extends UserReportState {}

// class UserReportLoading extends UserReportState {}

// class UserReportLoaded extends UserReportState {
//   final UserReport userReport;
//   const UserReportLoaded({required this.userReport});

//   @override
//   List<Object> get props => [userReport];
// }

// class UserReportError extends UserReportState {
//   final String error;
//   const UserReportError(this.error);
//   @override
//   List<Object> get props => [error];
// }
