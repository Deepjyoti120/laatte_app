part of 'api_state_services_bloc.dart';

@immutable
sealed class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PostFetched extends PostEvent {
  
}
