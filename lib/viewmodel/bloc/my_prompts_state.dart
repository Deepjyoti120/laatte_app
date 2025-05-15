part of 'my_prompts_bloc.dart';

class MyPromptsState extends Equatable {
  final ResponseStatus status;
  final String? error;
  final List<Prompt> prompts;
  final List<Prompt> listPrompt;
  final bool hasReachedMax;
  final int page;
  final bool isEmpty;
  const MyPromptsState({
    this.status = ResponseStatus.initial,
    this.error,
    this.prompts = const [],
    this.hasReachedMax = false,
    this.page = 1,
    this.listPrompt = const [],
    this.isEmpty = false,
  });
  MyPromptsState copyWith({
    ResponseStatus? status,
    String? error,
    List<Prompt>? prompts,
    bool? hasReachedMax,
    int? page,
    List<Prompt>? listPrompt,
    bool? isEmpty,
  }) {
    return MyPromptsState(
      status: status ?? this.status,
      error: error ?? this.error,
      prompts: prompts ?? this.prompts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      listPrompt: listPrompt ?? this.listPrompt,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        prompts,
        hasReachedMax,
        page,
        listPrompt,
        isEmpty,
      ];
}
