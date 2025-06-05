import 'package:laatte/common_libs.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "/ProfileScreen";
  const ProfileScreen({super.key, required this.userReport});
  final UserReport userReport;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<UserReportBloc>().add(UserReportFetched());
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.watch<UserReportBloc>().state.userReport;
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
