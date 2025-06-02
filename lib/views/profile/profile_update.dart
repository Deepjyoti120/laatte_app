import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/viewmodel/bloc/user_report_bloc.dart';

class ProfileUpdateScreen extends StatefulWidget {
  static const String route = "/ProfileUpdateScreen";
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<UserReportBloc>().add(UserReportFetched());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserReportBloc>().state.userReport;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
