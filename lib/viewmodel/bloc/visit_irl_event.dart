part of 'visit_irl_bloc.dart';

sealed class VisitIrlEvent extends Equatable {
  const VisitIrlEvent();

  @override
  List<Object> get props => [];
}

final class VisitIrlFetch extends VisitIrlEvent {
}