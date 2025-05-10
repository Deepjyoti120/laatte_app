part of 'visit_irl_bloc.dart';

 class VisitIrlState extends Equatable {
  const VisitIrlState({
    this.status = ResponseStatus.initial,
    this.visitIrls = const <VisitIrl?>[],
  });
  final ResponseStatus status;
  final List<VisitIrl?> visitIrls;

  VisitIrlState copyWith({
    ResponseStatus? status,
    List<VisitIrl?>? visitIrls,
  }) {
    return VisitIrlState(
      status: status ?? this.status,
      visitIrls: visitIrls ?? this.visitIrls,
    );
  }

  // const VisitIrlState.initial() : this(status: VisitIrlStatus.initial);
  
  @override
  List<Object?> get props => [
        status, 
        visitIrls,
  ];
}

// final class VisitIrlInitial extends VisitIrlState {}
