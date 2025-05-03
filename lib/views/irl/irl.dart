import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/theme/text.dart';

class IrlScreen extends StatefulWidget {
  static const String route = "/IrlScreen";
  const IrlScreen({super.key});

  @override
  State<IrlScreen> createState() => _IrlScreenState();
}

class _IrlScreenState extends State<IrlScreen> {
  @override
  void initState() {
    super.initState();
    runInit();
  }

  runInit() async {
    ApiService().irlVisit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DesignText(
          "Jan",
        ),
      ),
      //
    );
  }
}
