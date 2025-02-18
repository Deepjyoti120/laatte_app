part of 'user_report_bloc.dart';

abstract class UserReportEvent extends Equatable {
  const UserReportEvent();

  @override
  List<Object> get props => [];
}

class UserReportFetched extends UserReportEvent {}
class UserReportStorage extends UserReportEvent {}

