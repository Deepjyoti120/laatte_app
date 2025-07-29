part of 'my_prompts_bloc.dart';

sealed class MyPromptsEvent extends Equatable {
  const MyPromptsEvent();

  @override
  List<Object> get props => [];
}

class MyPromptsFetched extends MyPromptsEvent {}

class ListPromptsFetched extends MyPromptsEvent {
  final List<Prompt>? prompts;
  const ListPromptsFetched({this.prompts});
}

class ListPromptsSetEmpty extends MyPromptsEvent {
  final bool isEmpty;
  const ListPromptsSetEmpty({required this.isEmpty});
}
