part of 'my_prompts_bloc.dart';

sealed class MyPromptsEvent extends Equatable {
  const MyPromptsEvent();

  @override
  List<Object> get props => [];
}
class MyPromptsFetched extends MyPromptsEvent {}