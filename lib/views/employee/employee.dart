import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/ui/widgets/progress_circle.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/viewmodel/bloc/employee_bloc.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/views/home/profile_card.dart';

class Employee extends StatefulWidget {
  static const String route = "/Employee";
  const Employee({super.key});
  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(EmployeeFetch());
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
      floatingActionButton: appState.hasAddEmployeePermission
          ? FloatingActionButton(
              onPressed: () {
                final empContext = context.read<EmployeeBloc>();
                context.push<bool>(Routes.addEmployee).then((v) {
                  if (v ?? false) {
                    empContext.add(EmployeeFresh());
                  }
                });
              },
              child: const Icon(Icons.add),
            )
          : null,
      // body: ListView.builder(
      //   itemCount: 12,
      //   padding: const EdgeInsets.all(12),
      //   shrinkWrap: true,
      //   itemBuilder: (context, index) {
      //     return const Padding(
      //       padding: EdgeInsets.only(bottom: 8),
      //       child: ProfileCard(),
      //     );
      //   },
      // ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          switch (state.status) {
            case ResponseStatus.failure:
              return const Center(child: Text('failed to fetch data'));
            case ResponseStatus.success:
              if (state.employees.isEmpty) {
                return const Center(child: Text('no data'));
              }
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                itemCount: state.hasReachedMax
                    ? state.employees.length
                    : state.employees.length + 1,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= state.employees.length) {
                    return const Center(child: DesignProgress());
                  } else {
                    final data = state.employees[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ProfileCard(user: data),
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
    if (_isBottom) context.read<EmployeeBloc>().add(EmployeeFetch());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
