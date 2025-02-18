import 'package:laatte/common_libs.dart';
import 'package:laatte/ui/illustrations/attendance_illustration.dart';
import 'package:laatte/ui/illustrations/welcome_illustration.dart';
import 'package:laatte/ui/illustrations/wonder_illustration_config.dart';
import 'package:laatte/viewmodel/model/wonder_type.dart';

import 'employee_report_illustration.dart';

/// Convenience class for showing an illustration when all you have is the type.
class WonderIllustration extends StatelessWidget {
  const WonderIllustration(this.type, {super.key, required this.config});
  final WonderIllustrationConfig config;
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    // return ChichenItzaIllustration(config: config);
    return switch (type) {
      WonderType.chichenItza => WelcomeIllustration(config: config),
      WonderType.christRedeemer => ChichenItzaIllustration2(config: config),
      WonderType.employeeReports => EmployeeReportIllustration(config: config),
      _ => const SizedBox.shrink(),
    };
  }
}
