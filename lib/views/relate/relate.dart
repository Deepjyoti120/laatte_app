import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/viewmodel/bloc/my_prompts_bloc.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';

import '../../ui/widgets/progress_circle.dart';

class RelateScreen extends StatefulWidget {
  static const String route = "/RelateScreen";
  const RelateScreen({super.key});

  @override
  State<RelateScreen> createState() => _RelateScreenState();
}

class _RelateScreenState extends State<RelateScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MyPromptsBloc>().add(MyPromptsFetched());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const DesignText("Employee"),
      ),
      body: BlocBuilder<MyPromptsBloc, MyPromptsState>(
        builder: (context, state) {
          switch (state.status) {
            case ResponseStatus.failure:
              return const Center(child: Text('failed to fetch data'));
            case ResponseStatus.success:
              if (state.prompts.isEmpty) {
                return const Center(child: Text('no data'));
              }
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                itemCount: state.hasReachedMax
                    ? state.prompts.length
                    : state.prompts.length + 1,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= state.prompts.length) {
                    return const Center(child: DesignProgress());
                  } else {
                    final data = state.prompts[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      // child: ProfileCard(user: data),
                    );
                  }
                },
              );
            case ResponseStatus.initial:
              return const Center(child: DesignProgress());
            default:
              return const Center(child: DesignProgress());
          }
        },
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<MyPromptsBloc>().add(MyPromptsFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
